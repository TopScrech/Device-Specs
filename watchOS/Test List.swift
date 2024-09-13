import SwiftUI

struct TestList: View {
    private let colorTests: [String: Color] = [
        "White": Color(red: 1, green: 1, blue: 1),
        "Black": Color(red: 0, green: 0, blue: 0),
        "Red": Color(red: 1, green: 0, blue: 0),
        "Green": Color(red: 0, green: 1, blue: 0),
        "Blue": Color(red: 0, green: 0, blue: 1)
    ]
    
    var body: some View {
        List {
            Section("Static colors") {
                ForEach(colorTests.keys.sorted(), id: \.self) { key in
                    NavigationLink(key) {
                        ColorTestView(colorTests[key]!)
                    }
                }
            }
        }
    }
}

#Preview {
    TestList()
}
