import SwiftUI
import DeviceKit

@Observable
final class SystemVM {
    private let device = Device.current
    
    var buildNumber = ""
    
    var multitaskingSupported: String {
#if os(watchOS)
        "No"
#else
        UIDevice.current.isMultitaskingSupported ? "Yes" : "No"
#endif
    }
    
    
    init() {
        fetchBuildNumber()
    }
    
    var supportsAppleIntelligence: Bool {
        device.supportsAppleIntelligence
    }
    
    var operatingSystem: String {
#if os(watchOS)
        "\(WKInterfaceDevice.current().systemName) \(WKInterfaceDevice.current().systemVersion)"
#else
        "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
#endif
    }
    
    func fetchBuildNumber() {
        let build = ProcessInfo.processInfo.operatingSystemVersionString
        
        if let range = build.range(of: "\\((Build )([A-Za-z0-9]+)\\)", options: .regularExpression) {
            buildNumber = String(build[range]).replacingOccurrences(of: "(Build ", with: "")
                .replacingOccurrences(of: ")", with: "")
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
    
    func fetchSystemActiveTime() -> String {
        var bootTime = timeval()
        var mib = [CTL_KERN, KERN_BOOTTIME]
        var size = MemoryLayout<timeval>.stride
        
        let result = sysctl(&mib, UInt32(mib.count), &bootTime, &size, nil, 0)
        
        if result != 0 {
            perror("sysctl")
            return "Error fetching boot time"
        }
        
        let bootDate = Date(timeIntervalSince1970: TimeInterval(bootTime.tv_sec))
        let activeTimeInterval = Date().timeIntervalSince(bootDate)
        
        let totalSeconds = Int(activeTimeInterval)
        let days = totalSeconds / 86400
        let hours = (totalSeconds % 86400) / 3600
        let minutes = (totalSeconds % 3600) / 60
        
        let formattedActiveTime = "\(days)d \(hours)h \(minutes)m"
        
        return formattedActiveTime
    }
}
