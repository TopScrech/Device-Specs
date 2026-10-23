import ScrechKit
import Device

#if canImport(NearbyInteraction)
import NearbyInteraction
#endif

@Observable
final class DeviceVM {
    private(set) var isForceTouchAvailable = ""
    
    private static var isDebugDevicePad: Bool {
#if os(iOS)
        Device.current.identifier.hasPrefix("iPad")
#else
        false
#endif
    }

    private static var debugDeviceName: String {
        isDebugDevicePad ? "iPad Pro 13-inch (M5)" : "iPhone 18 Pro Max"
    }

    static var deviceName: String {
#if os(watchOS)
        ValueStore.debugValue(WKInterfaceDevice.current().name, override: debugDeviceName)
#else
        ValueStore.debugValue(UIDevice.current.name, override: debugDeviceName)
#endif
    }

    static var deviceIdentifier: String {
        ValueStore.debugValue(Device.current.name ?? liveHardwareIdentifier, override: debugDeviceName)
    }

    static var hardwareIdentifier: String {
        ValueStore.debugValue(liveHardwareIdentifier, override: isDebugDevicePad ? "iPad17,4" : "iPhone19,7")
    }

    private static let liveHardwareIdentifier = Device.current.identifier

#if os(iOS)
    static let hasWirelessCharging = Device.current.has(.wirelessCharging)
    static let supports5G = Device.current.has(.fiveG)
    static let hasDynamicIsland = Device.current.has(.dynamicIsland)
#endif
    
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
    
    static let isUWBAvailable = DeviceCapabilities.isUltraWidebandAvailable
    
    var vendorID: String {
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
