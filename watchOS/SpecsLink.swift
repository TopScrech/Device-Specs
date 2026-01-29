import SwiftUI

struct SpecsLink<Destination: View>: View {
    private let name: LocalizedStringKey
    private let icon: String
    private let spec: String
    private let destination: () -> Destination
    
    init(
        _ name: LocalizedStringKey,
        icon: String,
        spec: String = "",
        destination: @escaping () -> Destination
    ) {
        self.name = name
        self.icon = icon
        self.spec = spec
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .semibold()
                    .title3()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(name)
                    
                    if !spec.isEmpty {
                        Text(spec)
                            .semibold()
                            .footnote()
                            .secondary()
                    }
                }
                .foregroundStyle(.foreground)
            }
        }
    }
}
