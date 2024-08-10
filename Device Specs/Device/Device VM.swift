#if canImport(CoreNFC)
import ScrechKit
import CoreNFC
import NearbyInteraction

@Observable
final class DeviceVM {
    // Device
    let deviceName = UIDevice.modelName
    var deviceIdentifier: String?
    var architecture = ""
    
    // System
    let operatingSystem = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
    var buildNumber = ""
    
    // Capabilities
    let isNfcAvailable = NFCNDEFReaderSession.readingAvailable ? "Yes" : "No"
    var isForceTouchAvailable = ""
    var isUltraWidebandAvailable: String {
        if #available(iOS 16, watchOS 9, *) {
            NISession.deviceCapabilities.supportsPreciseDistanceMeasurement ? "Yes" : "No"
        } else {
            NISession.isSupported ? "Yes" : "No"
        }
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
        getArchitecture()
    }
    
    func getArchitecture() {
#if arch(arm64)
        architecture = "arm64"
#elseif arch(x86_64)
        architecture = "x86_64"
#elseif arch(i386)
        architecture = "i386"
#elseif arch(arm)
        architecture = "arm"
#else
        architecture = "unknown"
#endif
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
        deviceIdentifier = String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)?
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

#endif
