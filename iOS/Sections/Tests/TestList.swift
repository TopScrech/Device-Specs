import ScrechKit

struct TestList: View {
    @Environment(NavState.self) private var nav
    
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
                    nav.navigate(.toUwbTest)
                }
                .foregroundStyle(.foreground)
                .disabled(!DeviceCapabilities.isUltraWidebandAvailable)
            } footer: {
                if !DeviceCapabilities.isUltraWidebandAvailable {
                    Text("This device is not UWB-capable")
                }
            }
        }
        .navigationTitle("Tests")
        .scrollIndicators(.never)
        .sheet($sheetCamera) {
            CameraTest()
        }
    }
}

#Preview {
    NavigationStack {
        TestList()
    }
    .environment(NavState())
    .darkSchemePreferred()
}
