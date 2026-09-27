import SwiftUI

struct HomeViewCard<Destination: View>: View {
    private let title: LocalizedStringKey
    private let icon: String
    private let value: String
    private let detail: Text
    private let destination: () -> Destination
    
    init(
        _ title: LocalizedStringKey,
        icon: String,
        value: String,
        detail: Text,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.title = title
        self.icon = icon
        self.value = value
        self.detail = detail
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink {
            destination()
        } label: {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 5) {
                    Text(title)
                    
                    Spacer()
                    
                    Image(systemName: icon)
                        .title3()
                }
                .footnote()
                .secondary()
                .lineLimit(1)
                
                VStack(alignment: .leading, spacing: 1) {
                    Text(value.isEmpty ? "-" : value)
                        .title2(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .contentTransition(.numericText())
                    
                    detail
                        .caption()
                        .secondary()
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(14)
            .homeSurface()
            .contentShape(.rect(cornerRadius: 18))
        }
        .buttonStyle(.plain)
    }
}
