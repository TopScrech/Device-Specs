import Foundation
import OSLog

#if canImport(FoundationModels)
import FoundationModels
#endif

@Observable
@available(iOS 26, *)
final class ChatVM {
    var prompt = ""
    var streamedText = ""
    var transcriptTokens = 0.0
    var contextWindow = 0.0
    var answer: LanguageModelSession.Response<String>?
    
    var report: LanguageModelSession.Response<StreamResponse>?
    var partialReport: StreamResponse.PartiallyGenerated?
    
    private let logger = Logger()
    
    /// Range: 0.0...1.0
    var tokenUsage: Double {
        transcriptTokens / contextWindow
    }
    
    var renderedText: AttributedString {
        do {
            return try AttributedString(
                markdown: streamedText,
                options: AttributedString.MarkdownParsingOptions(
                    interpretedSyntax: .inlineOnlyPreservingWhitespace,
                    failurePolicy: .returnPartiallyParsedIfPossible
                )
            )
        } catch {
            return AttributedString(streamedText)
        }
    }
    
    private let tools: [any Tool] = [
        GetDeviceInfo(),
        GetSystemInfo(),
        GetDisplayInfo(),
        GetCPUInfo(),
        GetStorageInfo(),
        GetMemoryInfo(),
        GetCameraInfo()
    ]
    
    func printContextSize() {
        let contextSize = SystemLanguageModel.default.contextSize
        logger.info("Context size: \(contextSize)")
        
        contextWindow = Double(contextSize)
    }
    
    //    func processPromptAsReport() async {
    //        let model = SystemLanguageModel.default
    //
    //        switch model.availability {
    //        case .available:
    //            let session = LanguageModelSession(model: model, tools: tools) {
    //                """
    //                You are a helpful assistant.
    //                Provide concise answers.
    //                Answer only in the same language as the prompt.
    //                """
    //            }
    //
    //            do {
    //                streamedText = ""
    //                answer = nil
    //                partialReport = nil
    //                report = nil
    //
    //                let stream = session.streamResponse(
    //                    generating: StreamResponse.self,
    //                    includeSchemaInPrompt: true,
    //                    options: GenerationOptions()
    //                ) {
    //                    prompt
    //                }
    //
    //                for try await snapshot in stream {
    //                    partialReport = snapshot.content
    //                }
    //
    //                report = try await stream.collect()
    //            } catch {
    //                logger.error("\(error.localizedDescription)")
    //            }
    //
    //        case .unavailable(let reason):
    //            logger.error("\(String(describing: reason))")
    //        }
    //    }
    
    func processPromptAsText() async {
        let model = SystemLanguageModel.default
        
        switch model.availability {
        case .available:
            let instructions = Instructions("""
                You are a helpful assistant.
                Provide concise answers.
                Answer only in the same language as the prompt.
                When asked for all device information, provide the output of all available GET tools.
                """)
            
            let session = LanguageModelSession(model: model, tools: tools, instructions: instructions)
            
            if #available(iOS 26.4, *) {
                do {
                    let promptTokenUsage = try await model.tokenCount(for: prompt)
                    logger.info("Prompt tokens: \(promptTokenUsage)")
                    
                    let instructionsTokenUsage = try await model.tokenCount(for: instructions)
                    logger.info("Instruction tokens: \(instructionsTokenUsage)")
                    
                    let toolsTokenUsage = try await model.tokenCount(for: tools)
                    logger.info("Tools tokens: \(toolsTokenUsage)")
                    
                    let transcriptTokenUsage = try await model.tokenCount(for: session.transcript)
                    print("Transcript tokens: \(transcriptTokenUsage)")
                    
                    transcriptTokens = Double(transcriptTokenUsage)
                } catch {
                    logger.error("\(error)")
                }
            }
            
            do {
                partialReport = nil
                report = nil
                
                let stream = session.streamResponse(to: prompt)
                
                streamedText = ""
                
                for try await snapshot in stream {
                    streamedText = snapshot.content
                }
                
                answer = try await stream.collect()
                prompt = ""
                
                if #available(iOS 26.4, *) {
                    let transcriptTokenUsage = try await model.tokenCount(for: session.transcript)
                    print("Transcript tokens: \(transcriptTokenUsage)")
                    
                    transcriptTokens = Double(transcriptTokenUsage)
                }
            } catch {
                logger.error("\(error.localizedDescription)")
            }
            
        case .unavailable(let reason):
            logger.error("\(String(describing: reason))")
        }
    }
}
