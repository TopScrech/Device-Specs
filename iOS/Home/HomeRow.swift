import SwiftUI

struct HomeRow<Destination: View>: View {
    private let title: LocalizedStringKey
    private let icon: String
    private let value: String
    private let destination: () -> Destination
    
    init(
        _ title: LocalizedStringKey,
        icon: String,
        value: String = "",
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.title = title
        self.icon = icon
        self.value = value
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink {
            destination()
        } label: {
            HomeRowLabel(title, icon: icon, value: value)
        }
        .buttonStyle(.plain)
    }
}
