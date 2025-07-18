import ScrechKit

struct TestList: View {
    @Environment(NavState.self) private var navState
    
    @State private var sheetCamera = false
    
    var body: some View {
        List {
            Section {
                AuthTest()
            }
            
            Button("Camera", systemImage: "camera") {
                sheetCamera = true
            }
            .foregroundStyle(.foreground)
            
            ColorTestList()
            
            TorchTest()
            
            ListLink("Haptic feedback", icon: "hand.tap") {
                HapticTests()
            }
            
            Section {
                Button("Ultra Wideband", systemImage: "location.viewfinder") {
                    navState.navigate(.toUwbTest)
                }
                .foregroundStyle(.foreground)
                .disabled(!DeviceInfo.isUltraWidebandAvailable)
            } footer: {
                if !DeviceInfo.isUltraWidebandAvailable {
                    Text("This device is not UWB-capable")
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
