import SwiftUI
import DeviceKit

@Observable
final class SystemVM {
    private let device = Device.current
    
    private(set) var systemUptime = "N/a"
    private(set) var systemActiveTime = "N/a"
    
    var multitaskingSupported: String {
#if os(watchOS)
        "No"
#else
        UIDevice.current.isMultitaskingSupported ? "Yes" : "No"
#endif
    }
    
    static let timeZone = TimeZone.current.abbreviation()
    
    var lang: String {
        Locale.current.identifier
    }
    
    var fontCount: String {
        UIFont.familyNames.count.description
    }
    
    static var operatingSystem: String {
#if os(watchOS)
        let wkDevice = WKInterfaceDevice.current()
        return wkDevice.systemName + " " + wkDevice.systemVersion
#else
        let uiDevice = UIDevice.current
        return uiDevice.systemName + " " + uiDevice.systemVersion
#endif
    }
    
    static var buildNumber: String {
        let regex = "\\((Build )([A-Za-z0-9]+)\\)"
        let build = ProcessInfo.processInfo.operatingSystemVersionString
        
        guard
            let range = build.range(of: regex, options: .regularExpression)
        else {
            return "-"
        }
        
        return String(build[range])
            .replacing("(Build ", with: "")
            .replacing(")", with: "")
    }
    
    func fetchSystemUptime() {
        let uptime = ProcessInfo.processInfo.systemUptime
        systemUptime = timeFormatter(uptime)
    }
    
    func fetchSystemActiveTime() {
        var bootTime = timeval()
        var mib = [CTL_KERN, KERN_BOOTTIME]
        var size = MemoryLayout<timeval>.stride
        
        let result = sysctl(
            &mib, UInt32(mib.count),
            &bootTime, &size, nil, 0
        )
        
        if result != 0 {
            perror("sysctl")
            systemActiveTime = "Error fetching boot time"
        }
        
        let bootDate = Date(timeIntervalSince1970: TimeInterval(bootTime.tv_sec))
        let activeTimeInterval = Date().timeIntervalSince(bootDate)
        
        systemActiveTime = timeFormatter(activeTimeInterval)
    }
    
    private func timeFormatter(_ seconds: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 4
        
        if let formattedString = formatter.string(from: seconds) {
            return formattedString
        } else {
            return "N/a"
        }
    }
}
