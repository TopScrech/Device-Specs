import SwiftUI

struct WarningCard: View {
    private let title: LocalizedStringKey
    private let icon: String
    private let color: Color
    
    init(_ title: LocalizedStringKey, icon: String, color: Color) {
        self.title = title
        self.icon = icon
        self.color = color
    }
    
    var body: some View {
        HStack {
            Label {
                Text(title)
            } icon: {
                if #available(iOS 18, tvOS 18, visionOS 2, *) {
                    Image(systemName: icon)
                        .bold()
                        .foregroundStyle(color.gradient)
                        .symbolEffect(.breathe.pulse.byLayer, options: .repeat(.continuous))
                } else {
                    Image(systemName: icon)
                        .bold()
                        .foregroundStyle(color.gradient)
                }
            }
        }
    }
}

#Preview {
    WarningCard("Preview", icon: "exclamationmark.triangle", color: .yellow)
        .darkSchemePreferred()
}
