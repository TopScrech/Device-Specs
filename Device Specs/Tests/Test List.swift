import SwiftUI

struct TestList: View {
    @Environment(NavState.self) private var navState
    @State private var torch = TorchVM()
    
    private let colorTests = [
        "White": Color(red: 1, green: 1, blue: 1),
        "Black": Color(red: 0, green: 0, blue: 0),
        "Red": Color(red: 1, green: 0, blue: 0),
        "Green": Color(red: 0, green: 1, blue: 0),
        "Blue": Color(red: 0, green: 0, blue: 1)
    ]
    
    var body: some View {
        List {
            Section {
                Button("Ultra Wideband Test") {
                    navState.navigate(.toUwbTest)
                }
                .foregroundStyle(.foreground)
                .disabled(!DeviceInfo.isUltraWidebandAvailable)
            }
            
            Section("Static colors") {
                ForEach(colorTests.keys.sorted(), id: \.self) { key in
                    NavigationLink(key) {
                        ColorTestView(colorTests[key]!)
                    }
                }
            }
            
#if !targetEnvironment(simulator)
            Section("Flashlight") {
                Button {
                    torch.toggleTorch()
                } label: {
                    Label("Flashlight", systemImage: torch.isTorchOn ? "flashlight.on.fill" : "flashlight.off.fill")
                        .foregroundStyle(.foreground)
                }
            }
#endif
        }
    }
}

#Preview {
    TestList()
}
