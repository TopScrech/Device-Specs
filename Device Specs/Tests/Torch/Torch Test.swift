import SwiftUI

struct TorchTest: View {
    @State private var torch = TorchVM()
    
    private var icon: String {
        torch.isTorchOn ? "flashlight.on.fill" : "flashlight.off.fill"
    }
    
    var body: some View {
        Section {
            Button("Flashlight", systemImage: icon) {
                torch.toggleTorch()
            }
            .foregroundStyle(.foreground)
#if targetEnvironment(simulator)
            .disabled(true)
#endif
        }
    }
}

#Preview {
    List {
        TorchTest()
    }
}
