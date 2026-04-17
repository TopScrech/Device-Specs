import Foundation
import OSLog
import DeviceKit

#if canImport(FoundationModels)
import FoundationModels
#endif

@available(iOS 26, *)
struct GetCPUInfo: Tool {
    let name = "getCPUInfo"
    let description = "Gets information about the CPU of this device"
    
    @Generable
    struct Arguments {}
    
    @Generable
    struct CPUInfo {
        @Guide(description: "Name of CPU on this device")
        let name: String
    }
    
    func call(arguments: Arguments) async throws -> CPUInfo {
        CPUInfo(name: Device.current.cpu.description)
    }
}

@Observable
@available(iOS 26, *)
final class ChatVM {
    var prompt = ""
    var answer: LanguageModelSession.Response<String>? = nil
    
    func processPrompt() async {
        let model = SystemLanguageModel.default
        
        switch model.availability {
        case .available:
            let tools = [GetCPUInfo()]
            
            let session = LanguageModelSession(tools: tools) {
                "You are a helpful assistant. Provide concise answers. Answer only in the same language as the prompt"
            }
            
            do {
                answer = try await session.respond(to: prompt)
                print(answer?.content ?? "No answer")
            } catch {
                Logger().error("\(error)")
            }
            
            ///            Stream response
            
            //            let stream = try await session.streamResponse(
            //                generating: MyStruct.self,
            //                options: GenerationOptions(),
            //                includeSchemaInPrompt: false
            //            ) {
            //                "Please generate a report about SwiftUI views."
            //            }
            //
            //            for try await partial in stream {
            //                // `partial` is a MyStruct.PartiallyGenerated
            //                updateUI(with: partial)
            //            }
            
        case .unavailable(let reason):
            print(reason)
        }
    }
}
