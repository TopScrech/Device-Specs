import ScrechKit

@available(iOS 26, *)
struct ChatView: View {
    @State private var vm = ChatVM()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if vm.messages.isEmpty {
                    ContentUnavailableView(
                        "Ask about this device",
                        systemImage: "apple.intelligence",
                        description: Text("The assistant can answer follow-up questions and use the built-in device tools")
                    )
                } else {
                    ForEach(vm.messages) {
                        ChatMessageRowView($0)
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
        .toolbar {
            if #available(iOS 26.4, *) {
                ToolbarItem(placement: .topBarLeading) {
                    Gauge(value: vm.tokenUsage) {}
                        .gaugeStyle(.accessoryCircularCapacity)
                        .scaleEffect(0.5)
                        .buttonBorderShape(.circle)
                        .frame(30)
                        .tint(.green)
                        .animation(.default, value: vm.tokenUsage)
                }
            }
        }
        .overlay(alignment: .bottom) {
            ChatComposerView()
                .environment(vm)
        }
    }
}

@available(iOS 26, *)
#Preview {
    ChatView()
        .environmentObject(ValueStore())
}
