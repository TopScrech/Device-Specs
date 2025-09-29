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
            ForEach(colorTests) {
                ColorTestCard($0)
            }
        }
    }
}

#Preview {
    List {
        ColorTestList()
    }
    .darkSchemePreferred()
}
