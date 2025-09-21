import ScrechKit
import DeviceKit

struct CameraSpecs: View {
    @Environment(CameraVM.self) private var vm
    
    @State private var position = "Back"
    
    private var filteredCameras: [Camera] {
        vm.cameras.filter {
            $0.position == position
        }
    }
    
    var body: some View {
        List {
            Section {
                Picker("Position", selection: $position) {
                    Text("Front")
                        .tag("Front")
                    
                    Text("Back")
                        .tag("Back")
                }
            }
            
            ForEach(filteredCameras) {
                CameraView($0)
            }
        }
        .navigationTitle("Camera")
        .scrollIndicators(.never)
    }
}

#Preview {
    NavigationStack {
        CameraSpecs()
    }
    .environment(CameraVM())
}
