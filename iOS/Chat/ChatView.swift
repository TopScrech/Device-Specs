import ScrechKit
import ChitChat

@available(iOS 26, *)
struct ChatView: View {
    @State private var vm = ChatVM()
    
    @State private var alertTokenWindowUsage = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if vm.messages.isEmpty {
                    ContentUnavailableView(
                        "Ask about this device",
                        systemImage: "apple.intelligence",
                        description: Text("The assistant can answer follow-up questions and use the built-in device tools")
                    )
                    .symbolRenderingMode(.multicolor)
                } else {
                    ForEach(vm.messages) {
                        ChatMessageBubble($0)
                    }
                }
            }
            .scenePadding()
            .padding(.bottom, 40)
        }
        .navigationTitle("Assistant")
        .toolbarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            vm.printContextSize()
        }
        .alert("Token Window Usage", isPresented: $alertTokenWindowUsage) {
            
        } message: {
            Text("This indicator shows the amount of used tokens")
        }
        .overlay(alignment: .bottom) {
            ChatComposerView()
                .environment(vm)
        }
        .toolbar {
            if #available(iOS 26.4, visionOS 26.4, *) {
                ToolbarItem(placement: .topBarLeading) {
                    TokenUsageGauge(value: vm.tokenUsage) {
                        alertTokenWindowUsage = true
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NewChatButton(disabled: vm.isResponding || vm.messages.isEmpty, action: vm.startNewChat)
            }
        }
    }
}

@available(iOS 26, *)
#Preview {
    ChatView()
        .environmentObject(ValueStore())
}
