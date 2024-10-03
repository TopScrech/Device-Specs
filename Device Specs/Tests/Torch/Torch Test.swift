import SwiftUI

struct TorchTest: View {
    @State private var torch = TorchVM()
    
    var body: some View {
        Section("Flashlight") {
            Button {
                torch.toggleTorch()
            } label: {
                Label("Flashlight", systemImage: torch.isTorchOn ? "flashlight.on.fill" : "flashlight.off.fill")
                    .foregroundStyle(.foreground)
            }
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
