import ScrechKit
import DeviceKit

struct CameraSpecs: View {
    @State private var vm = CameraVM()
    
    var body: some View {
        List {
            ForEach(vm.cameras) { camera in
                CameraView(camera)
            }
        }
        .navigationTitle("Cameras")
    }
}

#Preview {
    CameraSpecs()
}
