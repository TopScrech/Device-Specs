import Foundation
import OSLog

#if canImport(FoundationModels)
import FoundationModels
#endif

@Observable
@available(iOS 26, *)
final class ChatVM {
    var prompt = ""
    
    func processPrompt() async {
        let model = SystemLanguageModel.default
        
        switch model.availability {
        case .available:
            let tools: [any Tool] = []
            
            let session = LanguageModelSession(tools: tools) {
                "You are a helpful assistant. Provide concise answers"
            }
            
            do {
                let answer = try await session.respond(to: prompt)
                print(answer.content)
            } catch {
                Logger().error("\(error)")
            }
            
        case .unavailable(let reason):
            print(reason)
        }
    }
}
