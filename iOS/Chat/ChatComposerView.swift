import ScrechKit

@available(iOS 26, *)
struct ChatComposerView: View {
    @Environment(ChatVM.self) private var vm
    
    @FocusState private var isFocused
    
    var body: some View {
        @Bindable var vm = vm
        
        HStack {
            TextField("Type here...", text: $vm.prompt)
                .onSubmit(sendPrompt)
                .frame(height: 35)
                .padding(.horizontal, 10)
                .glassEffect()
                .focused($isFocused)
                .submitLabel(.send)
                .disabled(vm.isResponding)
            
            Button(action: sendPrompt) {
                Image(systemName: "paperplane")
                    .frame(35)
                    .foregroundStyle(.foreground)
                    .glassEffect()
                    .fontSize(16)
            }
            .disabled(vm.isResponding || vm.prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding()
        .task {
            isFocused = true
        }
    }
    
    private func sendPrompt() {
        Task {
            await vm.sendPrompt()
        }
    }
}
