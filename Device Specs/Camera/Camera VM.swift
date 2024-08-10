import AVFoundation

@Observable
final class CameraVM {
    var frontMaxPhotoResolution = ""
    var frontApperture = ""
    var frontOpticalStabilization = ""
    
    init() {
        fetchFrontCameraInfo()
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
        var maxVideoResolution: CMVideoDimensions = CMVideoDimensions(width: 0, height: 0)
        
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
