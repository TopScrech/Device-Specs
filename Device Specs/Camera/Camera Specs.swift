import ScrechKit
import DeviceKit

struct CameraSpecs: View {
    @State private var vm = CameraVM()
    
    //    private let cameras = Device.current.cameras
    
    var body: some View {
        List {
            ForEach(vm.cameras) { camera in
                Section {
                    Text("Type: \(camera.typeDescription)")
                    Text("Position: \(camera.position)")
                    Text("Apperture: \(camera.lensApperture)")
                    Text("Exposure: \(camera.exposure)")
                    Text("Best format: \(camera.bestFormat)")
                }
            }
        }
        
        //            if !cameras.isEmpty {
        //                Section("Back cameras") {
        //                    ForEach(cameras, id: \.self) { camera in
        //                        switch camera {
        //                        case .wide:
        //                            Text("Wide")
        //
        //                        case .telephoto:
        //                            Text("Telephoto")
        //
        //                        case .ultraWide:
        //                            Text("Ultra wide")
        //
        //                        default:
        //                            Text("Unknown")
        //                        }
        //                    }
        //                }
        //        }
        .navigationTitle("Camera")
    }
}

#Preview {
    CameraSpecs()
}
