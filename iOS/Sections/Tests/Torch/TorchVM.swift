import AVFoundation
import OSLog

@Observable
final class TorchVM {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DeviceSpecs", category: "TorchVM")
    private(set) var isTorchOn = false
    
    init() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else {
            return
        }
        
        isTorchOn = device.torchMode == .on
    }
    
    func toggleTorch() {
        guard
            let device = AVCaptureDevice.default(for: .video),
            device.hasTorch
        else {
            return
        }
        
        do {
            try device.lockForConfiguration()
            
            if isTorchOn {
                device.torchMode = .off
            } else {
                try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
            }
            
            device.unlockForConfiguration()
            
            isTorchOn.toggle()
        } catch {
            logger.error("Torch could not be used")
        }
    }
}
