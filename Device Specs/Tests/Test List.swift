import SwiftUI

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
            
            ColorTestList()
            
            TorchTest()
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
