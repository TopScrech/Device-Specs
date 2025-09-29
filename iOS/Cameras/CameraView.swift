import ScrechKit

struct CameraView: View {
    private let camera: Camera
    
    init(_ camera: Camera) {
        self.camera = camera
    }
    
    var body: some View {
        Section(camera.name) {
            ListParam("Apperture", param: camera.lensApperture)
            
            ListParam("Exposure", param: camera.exposure)
            
            ListParam("Color space", param: camera.colorSpace)
            
            ListParam("ISO", param: camera.iso)
            
            ListParam("Manufacturer", param: camera.manufacturer)
            
            //            NavigationLink("Supported formats") {
            //                CameraFormats(camera.formats)
            //            }
            
            //            Text("Best format: \(camera.bestFormat)")
        }
    }
}

//#Preview {
//    List {
//        CameraView()
//    }
//    .darkSchemePreferred()
//}
