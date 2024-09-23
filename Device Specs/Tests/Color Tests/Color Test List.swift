import SwiftUI

struct ColorTestList: View {
    private let colorTests = [
        "White": Color(red: 1, green: 1, blue: 1),
        "Black": Color(red: 0, green: 0, blue: 0),
        "Red": Color(red: 1, green: 0, blue: 0),
        "Green": Color(red: 0, green: 1, blue: 0),
        "Blue": Color(red: 0, green: 0, blue: 1)
    ]
    
    var body: some View {
        Section("Static colors") {
            ForEach(colorTests.keys.sorted(), id: \.self) { key in
                NavigationLink {
                    if let color = colorTests[key] {
                        ColorView(color)
                    } else {
                        Text("Error")
                    }
                } label: {
                    Label {
                        Text(key)
                    } icon: {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(colorTests[key] ?? .secondary)
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
