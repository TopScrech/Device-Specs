import ScrechKit

@available(iOS 26, *)
struct ChatMessageRowView: View {
    private let message: ChatMessage
    
    init(_ message: ChatMessage) {
        self.message = message
    }
    
    var body: some View {
        HStack {
            if message.role == .assistant {
                Text(message.renderedText)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
            } else {
                Spacer()
                
                Text(message.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.tint.opacity(0.15), in: .rect(cornerRadius: 20))
            }
        }
    }
}
