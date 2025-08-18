import AVFoundation

struct Camera: Identifiable {
    let id = UUID()
    
    let name: String
    let lensApperture: String
    let position: String
    let exposure: String
    let colorSpace: String
    let iso: String
    let manufacturer: String
    let formats: [AVCaptureDevice.Format]
    
    var bestFormat: AVCaptureDevice.Format? {
        // Sort formats by highest frame rate first, then by highest resolution
        
        let sortedFormats = formats.sorted { format1, format2 -> Bool in
            // Retrieve the maximum frame rate for each format
            let maxFrameRate1 = format1.videoSupportedFrameRateRanges.map(\.maxFrameRate).max() ?? 0
            let maxFrameRate2 = format2.videoSupportedFrameRateRanges.map(\.maxFrameRate).max() ?? 0
            
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
