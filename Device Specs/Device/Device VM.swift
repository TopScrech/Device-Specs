import ScrechKit
import DeviceKit

#if canImport(LocalAuthentication)
import LocalAuthentication
#endif

#if canImport(NearbyInteraction)
import NearbyInteraction
#endif

#if canImport(CoreNFC)
import CoreNFC
#endif

@Observable
final class DeviceVM {
    private let device = Device.current
    
    var bioIcon = ""
    var bioType = ""
    
    var architecture = ""
    var isForceTouchAvailable = ""
    
    var deviceName: String {
        Device.current.name ?? "-"
    }
    
    var deviceIdentifier: String {
        device.description
    }
    
    var internalName: String {
        getInternalDeviceName() ?? "-"
    }
    
    var releaseDate: String {
        device.releaseDate
    }
    
    var bluetoothVersion: String {
        device.bluetoothVersion
    }
    
    var waterResistance: String {
        device.waterResistance
    }
    
    var waterResistanceDescription: String {
        device.waterResistanceDescription
    }
    
#if os(watchOS)
    var waterResistanceSystemRating: String {
        switch WKInterfaceDevice.current().waterResistanceRating {
        case .ipx7: "IPX7"
        case .wr50: "WR50"
        case .wr100: "WR100"
        default: "Unknown"
        }
    }
#endif
    
#warning("Finish")
    //    var deviceIcon: String {
    //        switch Device.current.name {
    //        case "iPhone":
    //            ""
    //
    //        default:
    //            ""
    //        }
    //    }
    
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
    
    var vandorId: String {
#if os(watchOS)
        WKInterfaceDevice.current().identifierForVendor?.uuidString ?? "-"
#else
        UIDevice.current.identifierForVendor?.uuidString ?? "-"
#endif
    }
    
    var thermalState: String {
        switch ProcessInfo.processInfo.thermalState {
        case .nominal: "Nominal"
        case .fair: "Fair"
        case .serious: "Serious"
        case .critical: "Critical"
        default: "Unknown"
        }
    }
    
    init() {
        fetchForceTouch()
        getBiometryType()
    }
    
    func getBiometryType() {
#if !os(tvOS)
        if #available(watchOS 11, *) {
            let type = LAContext().biometryType
            
            switch type {
            case .faceID:
                bioIcon = "faceid"
                bioType = "Face ID"
                
            case .touchID:
                bioIcon = "touchid"
                bioType = "Touch ID"
                
            case .opticID:
                bioIcon = "opticid"
                bioType = "Optic ID"
                
            case .none:
                bioIcon = ""
                bioType = "None"
                
            default:
                bioIcon = ""
                bioType = "Unknown"
            }
        } else {
            bioIcon = ""
            bioType = "None"
        }
#endif
    }
    
    func getInternalDeviceName() -> String? {
        var size = 0
        
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
