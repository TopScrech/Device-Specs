import AVFoundation

struct Camera: Identifiable {
    let id = UUID()
    
    let name: String
//    let type: AVCaptureDevice.DeviceType
    let lensApperture: String
    let position: String
    let exposure: String
    let colorSpace: String
    let iso: String
    let manufacturer: String
    let formats: [AVCaptureDevice.Format]
    
//    var typeDescription: String {
//        switch type {
//        case .builtInDualCamera: "Dual Camera"
//        case .builtInDualWideCamera: "Dual Wide Camera"
//        case .builtInLiDARDepthCamera: "LiDAR Depth Camera"
//        case .builtInTelephotoCamera: "Telephoto Camera"
//        case .builtInTripleCamera: "Triple Camera"
//        case .builtInTrueDepthCamera: "True Depth Camera"
//        case .builtInUltraWideCamera: "Ultra Wide Camera"
//        case .builtInWideAngleCamera: "Wide Angle Camera"
//        case .continuityCamera: "Continuity Camera"
//        case .external: "Webcam"
//        default: "Unknown Camera"
//        }
//    }
    
    var bestFormat: AVCaptureDevice.Format? {
        // Sort formats by highest frame rate first, then by highest resolution
        
        let sortedFormats = formats.sorted { format1, format2 -> Bool in
            // Retrieve the maximum frame rate for each format
            let maxFrameRate1 = format1.videoSupportedFrameRateRanges.map { $0.maxFrameRate }.max() ?? 0
            let maxFrameRate2 = format2.videoSupportedFrameRateRanges.map { $0.maxFrameRate }.max() ?? 0
            
            if maxFrameRate1 != maxFrameRate2 {
                // Higher frame rate comes first
                return maxFrameRate1 > maxFrameRate2
            } else {
                // If frame rates are equal, compare resolutions
                let dimensions1 = CMVideoFormatDescriptionGetDimensions(format1.formatDescription)
                let dimensions2 = CMVideoFormatDescriptionGetDimensions(format2.formatDescription)
                
                // Calculate the total number of pixels for each format
                let pixels1 = dimensions1.width * dimensions1.height
                let pixels2 = dimensions2.width * dimensions2.height
                
                // Higher resolution comes first
                return pixels1 > pixels2
            }
        }
        
        return sortedFormats.first
    }
}
