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
    
    private(set) var architecture = ""
    private(set) var isForceTouchAvailable = ""
    
    static let isMagsafeSupported = Device.current.hasMagsafe ? "Yes" : "No"
    static let deviceName = Device.current.name ?? "-"
    static let deviceIdentifier = Device.current.description
    static let releaseDate = Device.current.releaseDate
    static let bluetoothVersion = Device.current.bluetoothVersion
    static let waterResistance = Device.current.waterResistance
    static let waterResistanceDescription = Device.current.waterResistanceDescription
    static let dockConnector = Device.current.hasUSBCConnectivity ? "USB-C" : "Lightning"
    static let hasDynamicIsland = Device.current.hasDynamicIsland ? "Yes" : "No"
    
    var internalName: String {
        getInternalDeviceName() ?? "-"
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
    
    static var isUWBAvailable: String {
        DeviceCapabilities.isUltraWidebandAvailable ? "Yes" : "No"
    }
    
    var vendorId: String {
#if os(watchOS)
        WKInterfaceDevice.current().identifierForVendor?.uuidString ?? "-"
#else
        UIDevice.current.identifierForVendor?.uuidString ?? "-"
#endif
    }
    
    static var thermalState: String {
        switch ProcessInfo.processInfo.thermalState {
        case .nominal:  "Nominal"
        case .fair:     "Fair"
        case .serious:  "Serious"
        case .critical: "Critical"
        default:        "Unknown"
        }
    }
    
    init() {
        fetchForceTouch()
    }
    
    func getInternalDeviceName() -> String? {
        var size = 0
        
        // Get the size of the data to be returned
        if sysctlbyname("hw.model", nil, &size, nil, 0) != 0 {
            perror("sysctlbyname")
            return nil
        }
        
        // Allocate the appropriate amount of ram
        var model = [CChar](repeating: 0, count: size)
        
        // Retrieve the hardware model
        if sysctlbyname("hw.model", &model, &size, nil, 0) != 0 {
            perror("sysctlbyname")
            return nil
        }
        
        let internalName = String.decodeCString(model)
        
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
