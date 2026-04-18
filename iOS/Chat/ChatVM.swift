import Foundation
import OSLog

#if canImport(FoundationModels)
import FoundationModels
#endif

@Observable
@available(iOS 26, *)
final class ChatVM {
    var prompt = ""
    
    var answer: LanguageModelSession.Response<String>?
    var streamedText = ""
    
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
    
    var report: LanguageModelSession.Response<StreamResponse>?
    var partialReport: StreamResponse.PartiallyGenerated?
    
    private let logger = Logger()
    
    private let tools: [any Tool] = [
        GetDeviceInfo(),
        GetSystemInfo(),
        GetDisplayInfo(),
        GetCPUInfo(),
        GetStorageInfo(),
        GetMemoryInfo(),
        GetCameraInfo()
    ]
    
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
            let session = LanguageModelSession(model: model, tools: tools) {
                """
                You are a helpful assistant.
                Provide concise answers.
                Answer only in the same language as the prompt.
                When asked for all device information, provide the output of all available GET tools.
                """
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
            } catch {
                logger.error("\(error.localizedDescription)")
            }
            
        case .unavailable(let reason):
            logger.error("\(String(describing: reason))")
        }
    }
}
