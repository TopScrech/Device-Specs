import ScrechKit
import AVFoundation

struct FormatCard: View {
    private let format: AVCaptureDevice.Format
    
    init(_ format: AVCaptureDevice.Format) {
        self.format = format
    }
    
    var body: some View {
        Section {
            Text(format.videoFieldOfView)
        }
    }
}

//#Preview {
//    FormatCard()
//    .darkSchemePreferred()
//}
