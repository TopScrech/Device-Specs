import SwiftUI

struct ColorTestCard: View {
    private let item: ColorTest
    
    init(_ item: ColorTest) {
        self.item = item
    }
    
    var body: some View {
        NavigationLink {
            ColorView(item.color)
        } label: {
            Label {
                Text(item.name)
            } icon: {
                Image(systemName: "circle.fill")
                    .foregroundStyle(item.color)
                    .padding(1)
                    .background(.ultraThinMaterial, in: .circle)
            }
        }
    }
}

#Preview {
    List {
        ColorTestCard(.init("Preview", color: .gray))
    }
    .darkSchemePreferred()
}
