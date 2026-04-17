import SwiftUI

@available(iOS 26, *)
struct ChatView: View {
    @State private var vm = ChatVM()
    
    var body: some View {
        VStack {
            // Add a warning
            // Works best in the following languages:
            // English, Chinese (Simplified/Traditional), Danish, Dutch, French, German, Italian, Japanese, Korean, Norwegian, Portuguese, Spanish, Swedish, Turkish, and Vietnamese
            
            Text(vm.streamedText)
            
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
