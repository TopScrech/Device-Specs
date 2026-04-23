import Foundation
import OSLog

#if canImport(FoundationModels)
import FoundationModels
#endif

@Observable
@available(iOS 26, visionOS 26, *)
final class ChatVM {
    var prompt = ""
    var messages: [ChatMessage] = []
    var isResponding = false
    var transcriptTokens = 0.0
    var contextWindow = 0.0
    
    @ObservationIgnored private let logger = Logger()
    @ObservationIgnored private let model = SystemLanguageModel.default
    @ObservationIgnored private let instructions = Instructions("""
        You are a helpful assistant.
        Provide concise answers.
        Answer only in the same language as the prompt.
        When asked for all device information, provide the output of all available GET tools.
        """)
    @ObservationIgnored private let tools: [any Tool]
    @ObservationIgnored private var session: LanguageModelSession
    
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
            GetCameraInfo()
        ]
#endif
        session = LanguageModelSession(
            model: model,
            tools: tools,
            instructions: instructions
        )
    }
    
    func printContextSize() {
        let contextSize = model.contextSize
        logger.info("Context size: \(contextSize)")
        
        contextWindow = Double(contextSize)
    }
    
    func startNewChat() {
        guard !isResponding else { return }
        
        prompt = ""
        messages = []
        transcriptTokens = 0
        session = makeSession()
    }
    
    func sendPrompt() async {
        let userPrompt = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !userPrompt.isEmpty else { return }
        guard !isResponding else { return }
        
        switch model.availability {
        case .available:
            isResponding = true
            messages.append(ChatMessage(role: .user, text: userPrompt))
            messages.append(ChatMessage(role: .assistant, text: ""))
            prompt = ""
            
            do {
                let stream = session.streamResponse(to: userPrompt)
                
                for try await snapshot in stream {
                    if let messageIndex = messages.indices.last {
                        messages[messageIndex].text = snapshot.content
                    }
                }
                
                _ = try await stream.collect()
                await updateTranscriptTokenUsage()
                isResponding = false
            } catch {
                if let messageIndex = messages.indices.last {
                    messages[messageIndex].text = error.localizedDescription
                }
                
                logger.error("\(error.localizedDescription)")
                isResponding = false
            }
            
        case .unavailable(let reason):
            messages.append(ChatMessage(role: .assistant, text: "Model unavailable: \(String(describing: reason))"))
            logger.error("\(String(describing: reason))")
        }
    }
    
    private func updateTranscriptTokenUsage() async {
        guard #available(iOS 26.4, visionOS 26.4, *) else { return }
        
        do {
            let transcriptTokenUsage = try await model.tokenCount(for: session.transcript)
            logger.info("Transcript tokens: \(transcriptTokenUsage)")
            transcriptTokens = Double(transcriptTokenUsage)
        } catch {
            logger.error("\(error.localizedDescription)")
        }
    }
    
    private func makeSession() -> LanguageModelSession {
        LanguageModelSession(
            model: model,
            tools: tools,
            instructions: instructions
        )
    }
}
