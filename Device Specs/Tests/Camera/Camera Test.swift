import SwiftUI
import ScrechCam
import AVFoundation

struct CameraTest: View {
    @State private var cameraPosition: AVCaptureDevice.Position = .back
    
    var body: some View {
        ZStack {
            if cameraPosition == .back {
                CameraCapture(.back)
            } else {
                CameraCapture(.front)
            }
            
            VStack {
                Spacer()
                
                Button {
                    cameraPosition = cameraPosition == .back ? .front : .back
                } label: {
                    Text("Switch Camera")
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .foregroundStyle(.foreground)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    CameraTest()
}
