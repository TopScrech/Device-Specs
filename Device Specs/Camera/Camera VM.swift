import AVFoundation

@Observable
final class CameraVM {
    var frontMaxPhotoResolution = ""
    var frontApperture = ""
    var frontOpticalStabilization = ""
    
    var backAperture = ""
    var backMaxFrameRateInfo = ""
    var backMaxVideoResolution = ""
    var backOpticalStabilization = ""
    var backExposureRange = ""
    
    init() {
        fetchFrontCameraInfo()
        fetchBackCameraInfo()
    }
    
    func fetchBackCameraInfo() {
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .back
        )
        
        guard let device = discoverySession.devices.first else {
            print("No back camera device found.")
            return
        }
        
        var maxResolution = CMVideoDimensions(width: 0, height: 0)
        var maxResolutionFrameRate: Double = 0.0
        
        var maxFrameRate: Double = 0.0
        var maxFrameRateResolution = CMVideoDimensions(width: 0, height: 0)
        
        for format in device.formats {
            let dimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription)
            
            // Check for maximum resolution
            if dimensions.width * dimensions.height > maxResolution.width * maxResolution.height {
                maxResolution = dimensions
                
                // Find the maximum frame rate for this resolution
                if let highestFrameRate = format.videoSupportedFrameRateRanges.map({ $0.maxFrameRate }).max() {
                    maxResolutionFrameRate = highestFrameRate
                }
            }
            
            // Iterate through all frame rate ranges to find the highest frame rate
            for range in format.videoSupportedFrameRateRanges {
                if range.maxFrameRate > maxFrameRate {
                    maxFrameRate = range.maxFrameRate
                    maxFrameRateResolution = dimensions
                }
            }
        }
        
        // Construct the max video resolution string, e.g., "3840 x 2160 @ 30fps"
        if maxResolution.width != 0 && maxResolution.height != 0 {
            backMaxVideoResolution = "\(maxResolution.width) x \(maxResolution.height) @ \(Int(maxResolutionFrameRate))fps"
        } else {
            backMaxVideoResolution = "N/A"
        }
        
        // Construct the max frame rate info string, e.g., "60fps @ 1920 x 1080"
        if maxFrameRate > 0 && maxFrameRateResolution.width != 0 && maxFrameRateResolution.height != 0 {
            backMaxFrameRateInfo = "\(Int(maxFrameRate))fps @ \(maxFrameRateResolution.width) x \(maxFrameRateResolution.height)"
        } else {
            backMaxFrameRateInfo = "N/A"
        }
        
        // Lens Aperture
        backAperture = String(format: "%.1f", device.lensAperture)
        
        // Optical Stabilization Support (Cinematic Stabilization as an example)
        backOpticalStabilization = device.activeFormat.isVideoStabilizationModeSupported(.cinematic) ? "Yes" : "No"
        
        // Exposure Duration Range
        let minExposureSeconds = CMTimeGetSeconds(device.activeFormat.minExposureDuration)
        let maxExposureSeconds = CMTimeGetSeconds(device.activeFormat.maxExposureDuration)
        backExposureRange = String(format: "Speed Range: %.5f - %.5f seconds", minExposureSeconds, maxExposureSeconds)
        
        // Print the collected information
        print("Back Camera Aperture: \(backAperture)")
        print("Back Camera Max Video Resolution: \(backMaxVideoResolution)")
        print("Back Camera Max Frame Rate: \(backMaxFrameRateInfo)")
        print("Back Camera Optical Stabilization: \(backOpticalStabilization)")
        print("Back Camera Exposure Range: \(backExposureRange)")
    }
    
    func fetchFrontCameraInfo() {
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .front
        )
        
        guard let device = discoverySession.devices.first else {
            print("No device found for specified position.")
            return
        }
        
        // Max Video Resolution
        var maxVideoResolution = CMVideoDimensions(width: 0, height: 0)
        
        for format in device.formats {
            let dimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription)
            
            if dimensions.width * dimensions.height > maxVideoResolution.width * maxVideoResolution.height {
                maxVideoResolution = dimensions
            }
        }
        
        frontApperture = String(device.lensAperture)
        frontMaxPhotoResolution = "\(maxVideoResolution.width) x \(maxVideoResolution.height)"
        frontOpticalStabilization = device.activeFormat.isVideoStabilizationModeSupported(.cinematic) ? "Yes" : "No"
        
        //        // Max Photo Resolution
        //        let maxPhotoResolution = device.activeFormat.supportedMaxPhotoDimensions
        //        print("Max Photo Resolution: \(maxPhotoResolution.description)")
        
        // Speed (Exposure Duration)
        let shortestExposure = device.activeFormat.minExposureDuration
        let longestExposure = device.activeFormat.maxExposureDuration
        print("Speed Range: \(shortestExposure) - \(longestExposure)")
        
        print("Shortest Exposure: \(shortestExposure)")
        print("Longest Exposure: \(longestExposure)")
    }
    
    func fetchCameraData(_ position: AVCaptureDevice.Position) {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: position)
        
        guard let device = discoverySession.devices.first else {
            print("No device found for specified position.")
            return
        }
        
        // Max Video Resolution
        var maxVideoResolution: CMVideoDimensions = CMVideoDimensions(width: 0, height: 0)
        
        for format in device.formats {
            let dimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription)
            if dimensions.width * dimensions.height > maxVideoResolution.width * maxVideoResolution.height {
                maxVideoResolution = dimensions
            }
        }
        
        // Max Photo Resolution
        let maxPhotoResolution = device.activeFormat.supportedMaxPhotoDimensions
        print("Max Photo Resolution: \(maxPhotoResolution.description)")
        
        // Aperture
        let aperture = device.lensAperture
        print("Aperture: \(aperture)")
        
        // Speed (Exposure Duration)
        let shortestExposure = device.activeFormat.minExposureDuration
        let longestExposure = device.activeFormat.maxExposureDuration
        print("Speed Range: \(shortestExposure) - \(longestExposure)")
        
        // Optical Stabilization
        let isOpticalStabilizationSupported = device.activeFormat.isVideoStabilizationModeSupported(.cinematic)
        print("Optical Stabilization Supported: \(isOpticalStabilizationSupported)")
        
        print("Max Video Resolution: \(maxVideoResolution.width) x \(maxVideoResolution.height)")
        print("Shortest Exposure: \(shortestExposure)")
        print("Longest Exposure: \(longestExposure)")
    }
}
