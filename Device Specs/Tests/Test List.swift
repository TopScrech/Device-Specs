import SwiftUI

struct TestList: View {
    @Environment(NavState.self) private var navState
    
    @State private var sheetCamera = false
    
    var body: some View {
        List {
            Button("Camera") {
                sheetCamera = true
            }
            .foregroundStyle(.foreground)
            
            Section {
                Button("Ultra Wideband Test") {
                    navState.navigate(.toUwbTest)
                }
                .foregroundStyle(.foreground)
                .disabled(!DeviceInfo.isUltraWidebandAvailable)
            } footer: {
                if !DeviceInfo.isUltraWidebandAvailable {
                    Text("This device is not UWB capable")
                }
            }
            
            ColorTestList()
            
#if !EXTENSION
            TorchTest()
#endif
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
