import Foundation
import OSLog
import ChitChat

#if canImport(FoundationModels)
import FoundationModels
#endif

@Observable
@available(iOS 26, *)
final class ChatVM {
    private enum ModelProvider {
        case local, privateCloudCompute
    }
    
    var prompt = ""
    var messages: [DeviceChatMessage] = []
    var isResponding = false
    var transcriptTokens = 0.0
    var contextWindow = 0.0
    
    @ObservationIgnored private let logger = Logger()
    @ObservationIgnored private let localModel = SystemLanguageModel.default
    
    @ObservationIgnored private let instructions = Instructions("""
        You are a helpful assistant.
        Provide concise answers.
        Answer only in the same language as the prompt.
        When asked for all device information, provide the output of all available GET tools.
        """)
    
    @ObservationIgnored private let tools: [any Tool]
    @ObservationIgnored private var session: LanguageModelSession
    @ObservationIgnored private var modelProvider: ModelProvider
    
    /// Range: 0.0...1.0
    var tokenUsage: Double {
        guard contextWindow > 0 else { return 0 }
        
        return transcriptTokens / contextWindow
    }
    
    init() {
#if os(visionOS)
        tools = [
            GetDeviceInfo(),
            GetSystemInfo(),
            GetCPUInfo(),
            GetStorageInfo(),
            GetMemoryInfo(),
            GetBatteryInfo()
        ]
#else
        tools = [
            GetDeviceInfo(),
            GetSystemInfo(),
            GetDisplayInfo(),
            GetCPUInfo(),
            GetStorageInfo(),
            GetMemoryInfo(),
            GetBatteryInfo(),
            GetCameraInfo()
        ]
#endif
        modelProvider = Self.preferredModelProvider()
        session = Self.makeSession(for: modelProvider, tools: tools, instructions: instructions)
    }
    
    func printContextSize() async {
        do {
            let contextSize = try await contextSize(for: modelProvider)
            logger.info("Context size: \(contextSize)")
            
            contextWindow = Double(contextSize)
        } catch {
            logger.error("\(error.localizedDescription)")
            contextWindow = Double(localModel.contextSize)
        }
    }
    
    func startNewChat() {
        guard !isResponding else { return }
        
        prompt = ""
        messages = []
        transcriptTokens = 0
        modelProvider = Self.preferredModelProvider()
        session = Self.makeSession(for: modelProvider, tools: tools, instructions: instructions)
    }
    
    func sendPrompt() async {
        let userPrompt = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !userPrompt.isEmpty else { return }
        guard !isResponding else { return }
        
        if messages.isEmpty {
            prepareSessionForNewChat()
        }
        
        if case .local = modelProvider, let unavailableReason = localUnavailableReason {
            messages.append(DeviceChatMessage(role: .assistant, text: "Model unavailable: \(unavailableReason)", name: modelDisplayName))
            logger.error("\(unavailableReason)")
            return
        }
        
        isResponding = true
        messages.append(DeviceChatMessage(role: .user, text: userPrompt))
        messages.append(DeviceChatMessage(role: .assistant, text: "", name: modelDisplayName))
        prompt = ""
        
        do {
            try await streamResponse(to: userPrompt)
        } catch {
            guard modelProvider == .privateCloudCompute else {
                finishResponse(with: error)
                return
            }
            
            logger.error("Private Cloud Compute failed: \(error.localizedDescription)")
            modelProvider = .local
            session = Self.makeSession(for: .local, tools: tools, instructions: instructions)
            
            if let messageIndex = messages.indices.last {
                messages[messageIndex].text = ""
                messages[messageIndex].name = "Private Cloud Compute failed, using \(modelDisplayName)"
            }
            
            do {
                try await streamResponse(to: userPrompt)
            } catch {
                finishResponse(with: error)
                return
            }
        }
        
        isResponding = false
    }
    
    private func updateTranscriptTokenUsage() async {
        if #available(anyAppleOS 27, *) {
            transcriptTokens = Double(session.usage.totalTokenCount)
            return
        }
        
        guard #available(anyAppleOS 26.4, *) else { return }
        
        do {
            let transcriptTokenUsage = try await localModel.tokenCount(for: session.transcript)
            logger.info("Transcript tokens: \(transcriptTokenUsage)")
            transcriptTokens = Double(transcriptTokenUsage)
        } catch {
            logger.error("\(error.localizedDescription)")
        }
    }
    
    private func streamResponse(to userPrompt: String) async throws {
        await updateTranscriptTokenUsage()
        
        if #available(anyAppleOS 27, *) {
            let stream = session.streamResponse(to: userPrompt, contextOptions: contextOptionsForCurrentModel())
            try await consume(stream)
        } else {
            let stream = session.streamResponse(to: userPrompt)
            try await consume(stream)
        }
        
        await updateTranscriptTokenUsage()
    }
    
    private func consume(_ stream: sending LanguageModelSession.ResponseStream<String>) async throws {
        for try await snapshot in stream {
            if let messageIndex = messages.indices.last {
                messages[messageIndex].text = snapshot.content
            }
        }
        
        _ = try await stream.collect()
    }
    
    private func finishResponse(with error: any Error) {
        if let messageIndex = messages.indices.last {
            messages[messageIndex].text = error.localizedDescription
        }
        
        logger.error("\(error.localizedDescription)")
        isResponding = false
    }
    
    private var localUnavailableReason: String? {
        switch localModel.availability {
        case .available:
            nil
            
        case .unavailable(let reason):
            String(describing: reason)
        }
    }
    
    private var modelDisplayName: String {
        switch modelProvider {
        case .local:
            if #available(anyAppleOS 27, *), localModel.capabilities.contains(.reasoning) {
                return "Foundation Models, Deep Reasoning"
            }
            
            return "Foundation Models"
            
        case .privateCloudCompute:
            if #available(anyAppleOS 27, *), PrivateCloudComputeLanguageModel().capabilities.contains(.reasoning) {
                return "Private Cloud Compute, Deep Reasoning"
            }
            
            return "Private Cloud Compute"
        }
    }
    
    @available(anyAppleOS 27, *)
    private func contextOptionsForCurrentModel() -> ContextOptions {
        switch modelProvider {
        case .local:
            if localModel.capabilities.contains(.reasoning) {
                return ContextOptions(reasoningLevel: .deep)
            }
            
        case .privateCloudCompute:
            if PrivateCloudComputeLanguageModel().capabilities.contains(.reasoning) {
                return ContextOptions(reasoningLevel: .deep)
            }
        }
        
        return ContextOptions()
    }
    
    private func prepareSessionForNewChat() {
        modelProvider = Self.preferredModelProvider(logger: logger)
        session = Self.makeSession(for: modelProvider, tools: tools, instructions: instructions)
    }
    
    private func contextSize(for modelProvider: ModelProvider) async throws -> Int {
        switch modelProvider {
        case .local:
            localModel.contextSize
            
        case .privateCloudCompute:
            if #available(anyAppleOS 27, *) {
                try await PrivateCloudComputeLanguageModel().contextSize
            } else {
                localModel.contextSize
            }
        }
    }
    
    private static func preferredModelProvider(logger: Logger? = nil) -> ModelProvider {
        if #available(anyAppleOS 27, *) {
            switch PrivateCloudComputeLanguageModel().availability {
            case .available:
                logger?.info("Using Private Cloud Compute")
                return .privateCloudCompute
                
            case .unavailable(let reason):
                logger?.info("Private Cloud Compute unavailable: \(String(describing: reason))")
            }
        }
        
        logger?.info("Using Foundation Models")
        return .local
    }
    
    private static func makeSession(for modelProvider: ModelProvider, tools: [any Tool], instructions: Instructions) -> LanguageModelSession {
        switch modelProvider {
        case .local:
            LanguageModelSession(
                model: SystemLanguageModel.default,
                tools: tools,
                instructions: instructions
            )
            
        case .privateCloudCompute:
            if #available(anyAppleOS 27, *) {
                LanguageModelSession(
                    model: PrivateCloudComputeLanguageModel(),
                    tools: tools,
                    instructions: instructions
                )
            } else {
                LanguageModelSession(
                    model: SystemLanguageModel.default,
                    tools: tools,
                    instructions: instructions
                )
            }
        }
    }
}
