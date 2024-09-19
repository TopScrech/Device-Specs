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
    
    // Capabilities
    var isNfcAvailable: String {
#if canImport(CoreNFC)
        NFCNDEFReaderSession.readingAvailable ? "Yes" : "No"
#else
        "No"
#endif
    }
    
    var isForceTouchAvailable = ""
    
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
