import ScrechKit

struct AdView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.openURL) private var openURL
    
    private let title: String
    private let subtitle: String
    private let url: URL
    
    init(_ title: String, subtitle: String, url: URL) {
        self.title = title
        self.subtitle = subtitle
        self.url = url
    }
    
    private let backgroundRounding = 20.0
    
    private var backgroundColor: Color {
        colorScheme == .dark
        ? Color(red: 0.06, green: 0.09, blue: 0.13)
        : Color(red: 0.97, green: 0.98, blue: 0.98)
    }
    
    var body: some View {
        Button {
            openURL(url)
        } label: {
            HStack {
                Image(.fanControl)
                    .resizable()
                    .scaledToFit()
                    .frame(40)
                    .clipShape(.rect(cornerRadius: 8))
                
                VStack(alignment: .leading) {
                    Text(title)
                        .title3(.semibold)
                    
                    Text(subtitle)
                        .secondary()
                        .footnote()
                }
                
                Spacer()
                
                Image(systemName: "arrow.up.forward.circle.fill")
                    .imageScale(.large)
                    .symbolRenderingMode(.hierarchical)
                    .padding(.trailing, 5)
            }
            .foregroundStyle(.primary)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: backgroundRounding)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.29, green: 0.64, blue: 1).opacity(0.26),
                                Color(red: 0.16, green: 0.52, blue: 0.91).opacity(0.18),
                                backgroundColor
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .overlay {
                RoundedRectangle(cornerRadius: backgroundRounding)
                    .stroke(Color(red: 0.29, green: 0.64, blue: 1).opacity(0.32))
            }
        }
        .buttonStyle(.plain)
        .listRowBackground(Color.clear)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

#Preview {
    let url = URL(string: "https://fancontrol.dev?source=device-specs")!
    
    List {
        AdView("FanControl", subtitle: "Keep Your Mac Cool and Quiet", url: url)
    }
    .darkSchemePreferred()
}
