import SwiftUI

struct SpecsLink<Destination: View>: View {
    private let name: LocalizedStringKey
    private let icon: String
    private let spec: String
    private let destination: () -> Destination
    
    init(_ name: LocalizedStringKey, icon: String, spec: String = "", destination: @escaping () -> Destination) {
        self.name = name
        self.icon = icon
        self.spec = spec
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Label(name, systemImage: icon)
                    .foregroundStyle(.foreground)
                
                Spacer()
                
                if !spec.isEmpty {
                    Text(spec)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
