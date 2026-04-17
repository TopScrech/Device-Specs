import ScrechKit

@available(iOS 26, *)
struct ChatView: View {
    @State private var vm = ChatVM()
    
    var body: some View {
        VStack {
            // Add a warning
            // Works best in the following languages:
            // English, Chinese (Simplified/Traditional), Danish, Dutch, French, German, Italian, Japanese, Korean, Norwegian, Portuguese, Spanish, Swedish, Turkish, and Vietnamese
            
            Text(vm.streamedText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            HStack {
                TextField("Type here...", text: $vm.prompt)
                    .frame(height: 32)
                    .padding(.horizontal, 10)
                    .glassEffect()
                    .onSubmit(sendPrompt)
                    .submitLabel(.send)
                
                SFButton("paperplane", action: sendPrompt)
                    .foregroundStyle(.foreground)
                    .frame(32)
                    .glassEffect()
                    .fontSize(16)
            }
            .padding(.horizontal)
        }
    }
    
    private func sendPrompt() {
        Task {
            await vm.processPrompt()
        }
    }
}

@available(iOS 26, *)
#Preview {
    ChatView()
}
