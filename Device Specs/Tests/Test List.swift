import ScrechKit

struct TestList: View {
    @Environment(NavState.self) private var navState
    
    @State private var sheetCamera = false
    
    var body: some View {
        List {
            Button {
                sheetCamera = true
            } label: {
                Label("Camera", systemImage: "camera")
            }
            .foregroundStyle(.foreground)
            
            ColorTestList()
            
            TorchTest()
            
            ListLink("Haptic feedback", icon: "hand.tap") {
                HapticTests()
            }
            
            Section {
                Button {
                    navState.navigate(.toUwbTest)
                } label: {
                    Label("Ultra Wideband Test", systemImage: "location.viewfinder")
                }
                .foregroundStyle(.foreground)
                .disabled(!DeviceInfo.isUltraWidebandAvailable)
            } footer: {
                if !DeviceInfo.isUltraWidebandAvailable {
                    Text("This device is not UWB capable")
                }
            }
        }
        .navigationTitle("Tests")
        .sheet($sheetCamera) {
            CameraTest()
        }
    }
}

#Preview {
    TestList()
}
