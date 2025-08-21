import SwiftUI

struct ColorTestList: View {
    private let colorTests: [ColorTest] = [
        .init("White", color: .white),
        .init("Black", color: .black),
        .init("Red", color: .red),
        .init("Green", color: .green),
        .init("Blue", color: .blue)
    ]
    
    var body: some View {
        Section("Static colors") {
            ForEach(colorTests) { item in
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
    }
}

#Preview {
    List {
        ColorTestList()
    }
}
