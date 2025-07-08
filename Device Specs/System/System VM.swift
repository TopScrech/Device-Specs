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
    
    var timeZone: String {
        TimeZone.current.abbreviation() ?? ""
    }
    
    var lang: String {
        Locale.current.identifier
    }
    
    var fontCount: String {
        UIFont.familyNames.count.description
    }
    
    var operatingSystem: String {
#if os(watchOS)
        "\(WKInterfaceDevice.current().systemName) \(WKInterfaceDevice.current().systemVersion)"
#else
        "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
#endif
    }
    
    var buildNumber: String {
        let build = ProcessInfo.processInfo.operatingSystemVersionString
        
        guard let range = build.range(of: "\\((Build )([A-Za-z0-9]+)\\)", options: .regularExpression) else {
            return "-"
        }
        
        return String(build[range]).replacingOccurrences(of: "(Build ", with: "")
            .replacingOccurrences(of: ")", with: "")
    }
    
    func fetchSystemUptime() {
        let uptime = ProcessInfo.processInfo.systemUptime
        systemUptime = timeFormatter(uptime)
    }
    
    func fetchSystemActiveTime() {
        var bootTime = timeval()
        var mib = [CTL_KERN, KERN_BOOTTIME]
        var size = MemoryLayout<timeval>.stride
        
        let result = sysctl(&mib, UInt32(mib.count), &bootTime, &size, nil, 0)
        
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
