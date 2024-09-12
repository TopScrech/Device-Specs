import ScrechKit

#if canImport(NearbyInteraction)
import NearbyInteraction
#endif

#if canImport(CoreNFC)
import CoreNFC
#endif

@Observable
final class DeviceVM {
    // Device
    var deviceIdentifier: String?
    var architecture = ""
    
    // System
    let operatingSystem = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
    var buildNumber = ""
    
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
        fetchBuildNumber()
        fetchDeviceModelIdentifier()
        fetchForceTouch()
    }
    
    func fetchForceTouch() {
        switch UIViewController().traitCollection.forceTouchCapability {
            
        case .available:
            isForceTouchAvailable = "Yes"
            
        default:
            isForceTouchAvailable = "No"
        }
    }
    
    func fetchSystemUptime() -> String {
        let uptime = ProcessInfo.processInfo.systemUptime
        
        let days = Int(uptime) / 86400
        let hours = (Int(uptime) % 86400) / 3600
        let minutes = (Int(uptime) % 3600) / 60
        
        let formattedUptime = "\(days)d \(hours)h \(minutes)m"
        
        return formattedUptime
    }
    
    func fetchDeviceModelIdentifier() {
        var sysinfo = utsname()
        uname(&sysinfo)
        
        let bytes = Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN))
        
        deviceIdentifier = String(bytes: bytes, encoding: .ascii)?
            .trimmingCharacters(in: .controlCharacters)
    }
    
    func fetchBuildNumber() {
        let build = ProcessInfo.processInfo.operatingSystemVersionString
        
        if let range = build.range(of: "\\((Build )([A-Za-z0-9]+)\\)", options: .regularExpression) {
            buildNumber = String(build[range]).replacingOccurrences(of: "(Build ", with: "")
                .replacingOccurrences(of: ")", with: "")
        }
    }
}
