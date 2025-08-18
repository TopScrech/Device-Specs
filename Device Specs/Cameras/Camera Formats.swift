import SwiftUI
import AVFoundation

struct CameraFormats: View {
    private let formats: [AVCaptureDevice.Format]
    
    init(_ formats: [AVCaptureDevice.Format]) {
        self.formats = formats
    }
    
    var body: some View {
        ForEach(formats, id: \.self) { format in
            FormatCard(format)
        }
    }
}

//#Preview {
//    CameraFormats()
//        .darkSchemePreferred()
//}
