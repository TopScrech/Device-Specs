import AVFoundation
import DeviceKit

@Observable
final class CameraVM {
    var cameras: [Camera] = []
    
    let hasLidar = Device.current.hasLidarSensor ? "LiDAR" : ""
    
    init() {
        test()
    }
    
    private func numberToString<T: Numeric>(_ value: T) -> String {
        if let doubleValue = value as? Float {
            String(format: "%g", doubleValue)
        } else if let floatValue = value as? Double {
            String(format: "%g", floatValue)
        } else {
            String(describing: value)
        }
    }
    
    func parseDevice(_ device: AVCaptureDevice) -> Camera? {
        var position = ""
        var exposure = ""
        var colorSpace = ""
        
        let apperture = numberToString(device.lensAperture)
        let manufacturer = device.manufacturer
        let formats = device.formats
        let iso = numberToString(device.iso)
        let name = device.localizedName
        
        switch device.activeColorSpace {
        case .HLG_BT2020:
            colorSpace = "HLG_BT2020"
            
        case .P3_D65:
            colorSpace = "P3_D65"
            
        case .sRGB:
            colorSpace = "sRGB"
            
        case .appleLog:
            colorSpace = "Apple Log"
            
        default:
            colorSpace = "Unknown"
        }
        
        switch device.exposureMode {
        case .autoExpose:
            exposure = "Auto"
            
        case .continuousAutoExposure:
            exposure = "Continuous Auto"
            
        case .locked:
            exposure = "Locked"
            
        case .custom:
            exposure = "Custom"
            
        default:
            exposure = "Unknown"
        }
        
        switch device.position {
        case .back:
            position = "Back"
            
        case .front:
            position = "Front"
            
        default:
            position = "Unknown"
        }
        
        return Camera(
            name: name,
            lensApperture: apperture,
            position: position,
            exposure: exposure,
            colorSpace: colorSpace,
            iso: iso,
            manufacturer: manufacturer,
            formats: formats
        )
    }
    
    func test() {
        let deviceTypes: [AVCaptureDevice.DeviceType] = [
            .builtInWideAngleCamera,
            .builtInDualCamera,
            .builtInDualWideCamera,
            .builtInLiDARDepthCamera,
            .builtInTelephotoCamera,
            .builtInTripleCamera,
            .builtInTrueDepthCamera,
            .builtInUltraWideCamera,
            .continuityCamera,
            .external,
            .microphone
        ]
        
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: deviceTypes,
            mediaType: .video,
            position: .back
        )
        
        let discoverySession2 = AVCaptureDevice.DiscoverySession(
            deviceTypes: deviceTypes,
            mediaType: .video,
            position: .front
        )
        
        var devices: [Camera] = []
        
        for device in discoverySession.devices + discoverySession2.devices {
            if let camera = parseDevice(device) {
                devices.append(camera)
            }
        }
        
        cameras = devices
        
        //        var maxResolution = CMVideoDimensions(width: 0, height: 0)
        //        var maxResolutionFrameRate = 0.0
        //
        //        var maxFrameRate = 0.0
        //        var maxFrameRateResolution = CMVideoDimensions(width: 0, height: 0)
        //
        //        for format in device.formats {
        //            let dimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription)
        //
        //            // Check for maximum resolution
        //            if dimensions.width * dimensions.height > maxResolution.width * maxResolution.height {
        //                maxResolution = dimensions
        //
        //                // Find the maximum frame rate for this resolution
        //                if let highestFrameRate = format.videoSupportedFrameRateRanges.map({ $0.maxFrameRate }).max() {
        //                    maxResolutionFrameRate = highestFrameRate
        //                }
        //            }
        //
        //            // Iterate through all frame rate ranges to find the highest frame rate
        //            for range in format.videoSupportedFrameRateRanges {
        //                if range.maxFrameRate > maxFrameRate {
        //                    maxFrameRate = range.maxFrameRate
        //                    maxFrameRateResolution = dimensions
        //                }
        //            }
        //        }
        //
        //        // Construct the max video resolution string, e.g., "3840 x 2160 @ 30fps"
        //        if maxResolution.width != 0 && maxResolution.height != 0 {
        //            backMaxVideoResolution = "\(maxResolution.width) x \(maxResolution.height) @ \(Int(maxResolutionFrameRate))fps"
        //        } else {
        //            backMaxVideoResolution = "N/A"
        //        }
        //
        //        // Construct the max frame rate info string, e.g., "60fps @ 1920 x 1080"
        //        if maxFrameRate > 0 && maxFrameRateResolution.width != 0 && maxFrameRateResolution.height != 0 {
        //            backMaxFrameRateInfo = "\(Int(maxFrameRate))fps @ \(maxFrameRateResolution.width) x \(maxFrameRateResolution.height)"
        //        } else {
        //            backMaxFrameRateInfo = "N/A"
        //        }
        //
        //        // Optical Stabilization Support (Cinematic Stabilization as an example)
        //        backOpticalStabilization = device.activeFormat.isVideoStabilizationModeSupported(.cinematic) ? "Yes" : "No"
        //
        //        // Exposure Duration Range
        //        let minExposureSeconds = CMTimeGetSeconds(device.activeFormat.minExposureDuration)
        //        let maxExposureSeconds = CMTimeGetSeconds(device.activeFormat.maxExposureDuration)
        //        backExposureRange = String(format: "Speed Range: %.5f - %.5f seconds", minExposureSeconds, maxExposureSeconds)
        //
        // Print the collected information
        //        print("Camera Aperture: \(backAperture)")
        //        print("Camera Max Video Resolution: \(backMaxVideoResolution)")
        //        print("Camera Max Frame Rate: \(backMaxFrameRateInfo)")
        //        print("Camera Optical Stabilization: \(backOpticalStabilization)")
        //        print("Camera Exposure Range: \(backExposureRange)")
    }
}
