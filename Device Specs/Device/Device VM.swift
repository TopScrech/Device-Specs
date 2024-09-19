import ScrechKit
import DeviceKit

#if canImport(NearbyInteraction)
import NearbyInteraction
#endif

#if canImport(CoreNFC)
import CoreNFC
#endif

@Observable
final class DeviceVM {
    // Device
    let deviceIdentifier = Device.current.description
    
    var architecture = ""
    var isForceTouchAvailable = ""
    let deviceName = Device.current.name ?? "-"
    
#warning("Finish")
        var deviceIcon: String {
            switch Device.current.name {
            case "iPhone":
                ""
    
            default:
                ""
            }
        }
    
    // Capabilities
    var isNfcAvailable: String {
#if canImport(CoreNFC)
        NFCNDEFReaderSession.readingAvailable ? "Yes" : "No"
#else
        "No"
#endif
    }
    
    var isUltraWidebandAvailable: String {
#if canImport(NearbyInteraction)
        if #available(iOS 16, watchOS 9, *) {
            NISession.deviceCapabilities.supportsPreciseDistanceMeasurement ? "Yes" : "No"
        } else {
            NISession.isSupported ? "Yes" : "No"
        }
#else
        "No"
#endif
    }
    
    var thermalState: String {
        switch ProcessInfo.processInfo.thermalState {
        case .nominal: "Nominal"
        case .fair: "Fair"
        case .serious: "Serious"
        case .critical: "Critical"
        @unknown default: "Unknown"
        }
    }
    
    init() {
        fetchForceTouch()
    }
    
    func getInternalDeviceName() -> String? {
        var size: Int = 0
        // Get the size of the data to be returned
        if sysctlbyname("hw.model", nil, &size, nil, 0) != 0 {
            perror("sysctlbyname")
            return nil
        }
        
        // Allocate the appropriate amount of memory
        var model = [CChar](repeating: 0, count: size)
        
        // Retrieve the hardware model
        if sysctlbyname("hw.model", &model, &size, nil, 0) != 0 {
            perror("sysctlbyname")
            return nil
        }
        
        let internalName = String(cString: model)
        
        return internalName
    }
    
    func fetchForceTouch() {
#if !os(watchOS)
        switch UIViewController().traitCollection.forceTouchCapability {
            
        case .available:
            isForceTouchAvailable = "Yes"
            
        default:
            isForceTouchAvailable = "No"
        }
#endif
    }
}
