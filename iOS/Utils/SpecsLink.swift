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
        NavigationLink {
            destination()
        } label: {
            HStack(spacing: 0) {
#if os(tvOS)
                Image(systemName: icon)
                    .frame(width: 64)
                
                Text(name)
                    .foregroundStyle(.foreground)
#else
                Label(name, systemImage: icon)
                    .foregroundStyle(.primary)
#endif
                Spacer()
                
                if !spec.isEmpty {
                    Text(spec)
                        .fontWeight(.medium)
                        .secondary()
                }
            }
        }
    }
}
