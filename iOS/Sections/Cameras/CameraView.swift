import SwiftUI

struct CameraView: View {
    private let camera: Camera
    
    init(_ camera: Camera) {
        self.camera = camera
    }
    
    var body: some View {
        Section(camera.name) {
            LabeledContent("Apperture", value: camera.lensApperture)
            
            LabeledContent("Exposure", value: camera.exposure)
            
            LabeledContent("Color space", value: camera.colorSpace)
            
            LabeledContent("ISO", value: camera.iso)
            
            LabeledContent("Manufacturer", value: camera.manufacturer)
            
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
