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
            }
            
            ColorTestList()
            
            TorchTest()
        }
        .sheet($sheetCamera) {
            CameraTest()
        }
    }
}

#Preview {
    TestList()
}
