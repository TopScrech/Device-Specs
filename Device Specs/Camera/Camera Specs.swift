import ScrechKit
import DeviceKit

struct CameraSpecs: View {
    private var vm = CameraVM()
    
    var body: some View {
        List {
#if DEBUG
            Button("Front camera test") {
                vm.fetchCameraData(.front)
            }
            
            Button("Back camera test") {
                vm.fetchCameraData(.back)
            }
#endif
            Section("Back cameras") {
                ForEach(Device.current.cameras, id: \.self) { camera in
                    switch camera {
                    case .wide:
                        Text("Wide")
                        
                    case .telephoto:
                        Text("Telephoto")
                        
                    case .ultraWide:
                        Text("Ultra wide")
                        
                    default:
                        Text("Unknown")
                    }
                }
            }
            
            Section("Front Camera") {
                ListParameter("Max Photo Resolution", parameter: vm.frontMaxPhotoResolution)
                
                ListParameter("Apperture", parameter: vm.frontApperture)
                
                ListParameter("Optical Stabilization", parameter: vm.frontOpticalStabilization)
            }
        }
        .navigationTitle("Camera")
    }
}

#Preview {
    CameraSpecs()
}
