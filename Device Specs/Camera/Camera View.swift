import SwiftUI

struct CameraView: View {
    private let camera: Camera
    
    init(_ camera: Camera) {
        self.camera = camera
    }
    
    var body: some View {
        Section(camera.name) {
            SpecCard("Apperture", spec: camera.lensApperture)
            
            SpecCard("Exposure", spec: camera.exposure)
            
            SpecCard("Color space", spec: camera.colorSpace)
            
            SpecCard("ISO", spec: camera.iso)
            
            SpecCard("Manufacturer", spec: camera.manufacturer)
            
            //            NavigationLink("Supported formats") {
            //                CameraFormats(camera.formats)
            //            }
            //
            //            Text("Best format: \(camera.bestFormat)")
        }
    }
}

//#Preview {
//    List {
//        CameraView()
//    }
//}
