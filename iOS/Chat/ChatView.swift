import ScrechKit

@available(iOS 26, *)
struct ChatView: View {
    @State private var vm = ChatVM()
    @EnvironmentObject private var store: ValueStore
    
    @FocusState private var isFocused
    
    var body: some View {
        ScrollView {
            // Add a warning
            // Works best in the following languages:
            // English, Chinese (Simplified/Traditional), Danish, Dutch, French, German, Italian, Japanese, Korean, Norwegian, Portuguese, Spanish, Swedish, Turkish, and Vietnamese
            
            Text(vm.renderedText)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Assistant")
        .toolbarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scenePadding()
        .task {
            isFocused = true
        }
        .toolbar {
            if store.debugMode {
                Menu {
                    Button(String("Print context size"), action: vm.printContextSize)
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .overlay(alignment: .bottom) {
            HStack {
                TextField("Type here...", text: $vm.prompt)
                    .frame(height: 32)
                    .padding(.horizontal, 10)
                    .glassEffect()
                    .onSubmit(sendPrompt)
                    .submitLabel(.send)
                    .focused($isFocused)
                
                SFButton("paperplane", action: sendPrompt)
                    .foregroundStyle(.foreground)
                    .frame(32)
                    .glassEffect()
                    .fontSize(16)
            }
            .padding()
        }
    }
    
    private func sendPrompt() {
        Task {
            await vm.processPromptAsText()
        }
    }
}

@available(iOS 26, *)
#Preview {
    ChatView()
        .environmentObject(ValueStore())
}
