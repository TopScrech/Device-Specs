import SwiftUI

@available(iOS 26, *)
struct ChatView: View {
    @State private var vm = ChatVM()
    
    var body: some View {
        VStack {
            if let answer = vm.answer {
                Text(answer.content)
            }
            
            TextField("Type here...", text: $vm.prompt)
            
            Button("Send") {
                Task {
                    await vm.processPrompt()
                }
            }
        }
    }
}

@available(iOS 26, *)
#Preview {
    ChatView()
}
