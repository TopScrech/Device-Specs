import ScrechKit
import DeviceKit

struct CameraSpecs: View {
    @State private var vm = CameraVM()
    
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
            
            ForEach(filteredCameras) { camera in
                CameraView(camera)
            }
        }
        .navigationTitle("Cameras")
        .scrollIndicators(.never)
    }
}

#Preview {
    CameraSpecs()
}
