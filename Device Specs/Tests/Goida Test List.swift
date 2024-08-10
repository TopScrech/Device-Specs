import SwiftUI

struct GoidaTestList: View {
    private let colorTests: [String: Color] = [
        "White": .white,
        "Black": .black,
        "Red": .red,
        "Green": .green,
        "Blue": .blue
    ]
    
    var body: some View {
        List {
            Section {
                NavigationLink("Ultra Wideband Test") {
                    UWTestView()
                }
                .disabled(!DeviceInfo.isUltraWidebandAvailable)
            }
            
            Section("Static color") {
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
    GoidaTestList()
}
