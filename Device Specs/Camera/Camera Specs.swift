import ScrechKit
import DeviceKit

struct CameraSpecs: View {
    @State private var vm = CameraVM()
    
    private let cameras = Device.current.cameras
    
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
            
            if !cameras.isEmpty {
                Section("Back cameras") {
                    ForEach(cameras, id: \.self) { camera in
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
                
#if DEBUG
                ListParameter("backAperture", parameter: vm.backAperture)
                ListParameter("backMaxFrameRateInfo", parameter: vm.backMaxFrameRateInfo)
                ListParameter("backMaxVideoResolution", parameter: vm.backMaxVideoResolution)
                ListParameter("backOpticalStabilization", parameter: vm.backOpticalStabilization)
                ListParameter("backExposureRange", parameter: vm.backExposureRange)
#endif
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
