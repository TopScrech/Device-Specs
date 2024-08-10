import SwiftUI

struct TestList: View {
    @State private var torch = TorchVM()
    
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
