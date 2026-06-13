import ScrechKit
import ChitChat

struct DeviceChatMessageRow: View {
    let message: DeviceChatMessage

    var body: some View {
        HStack {
            if message.role == .assistant {
                VStack(alignment: .leading) {
                    if let name = message.name {
                        Text(name)
                            .secondary()
                    }

                    Text(message.renderedText)
                }
                .padding()
                .background(.gray.opacity(0.15), in: .rect(cornerRadius: 20))
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
            } else {
                Text(message.text)
                    .padding()
                    .background(.tint.opacity(0.15), in: .rect(cornerRadius: 20))
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}
