import SwiftUI

struct ListLink <Destination: View>: View {
    private let title: LocalizedStringKey
    private let icon: String
    private let destination: Destination
    
    init(
        _ title: LocalizedStringKey,
        icon: String,
        @ViewBuilder destination: () -> Destination = { EmptyView() }
    ) {
        self.title = title
        self.icon = icon
        self.destination = destination()
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            Label(title, systemImage: icon)
                .foregroundStyle(.white)
                .symbolRenderingMode(.multicolor)
        }
    }
}

#Preview {
    List {
        ListLink("Preview", icon: "hammer") {}
    }
}
