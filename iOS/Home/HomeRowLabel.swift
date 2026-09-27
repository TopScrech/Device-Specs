import SwiftUI

struct HomeRowLabel: View {
    private let title: LocalizedStringKey
    private let icon: String
    private let value: String
    
    init(_ title: LocalizedStringKey, icon: String, value: String = "") {
        self.title = title
        self.icon = icon
        self.value = value
    }
    
    var body: some View {
        HStack {
            Label(title, systemImage: icon)
                .foregroundStyle(.primary)
            
            Spacer()
            
            if !value.isEmpty {
                Text(value)
                    .secondary()
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            
            Image(systemName: "chevron.forward")
                .caption(.semibold)
                .tertiary()
        }
        .padding(14)
        .contentShape(.rect)
    }
}
