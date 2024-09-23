import SwiftUI
import DeviceKit

@Observable
final class SystemVM {
    private let loc = Locale.current
    
    var buildNumber = ""
    
    var multitaskingSupported: String {
#if os(watchOS)
        "No"
#else
        UIDevice.current.isMultitaskingSupported ? "Yes" : "No"
#endif
    }
    
    var language: String {
        loc.identifier
    }
    
    var region: String {
        loc.region?.identifier ?? "-"
    }
    
    var containingRegion: String {
        loc.region?.containingRegion?.identifier ?? "-"
    }
    
    var subRegions: String {
        loc.region?.subRegions.description ?? "-"
    }
    
    var isISORegion: String {
        guard let isDefined = loc.region?.isISORegion else {
            return "-"
        }
        
        return isDefined ? "Yes" : "No"
    }
    
    var continent: String {
        loc.region?.continent?.identifier ?? "-"
    }
    
    var hourCycle: String {
        loc.hourCycle.rawValue
    }
    
    var availableNumberingSystems: String {
        loc.availableNumberingSystems.description
    }
    
    var numberingSystem: String {
        loc.numberingSystem.identifier
    }
    
    var collation: String {
        loc.collation.identifier
    }
    
    var collatorIdentifier: String {
        loc.collatorIdentifier ?? "-"
    }
    
    var firstDayOfWeek: String {
        loc.firstDayOfWeek.rawValue
    }
    
    var decimalSeparator: String {
        loc.decimalSeparator ?? "-"
    }
    
    var groupingSeparator: String {
        loc.groupingSeparator ?? "-"
    }
    
    var variant: String {
        loc.variant?.identifier ?? "-"
    }
    
    var subdivision: String {
        loc.subdivision?.identifier ?? "-"
    }
    
    var quotationBeginDelimiter: String {
        loc.quotationBeginDelimiter ?? "-"
    }
    
    var quotationEndDelimiter: String {
        loc.quotationEndDelimiter ?? "-"
    }
    
    var alternateQuotationBeginDelimiter: String {
        loc.alternateQuotationBeginDelimiter ?? "-"
    }
    
    var alternateQuotationEndDelimiter: String {
        loc.alternateQuotationEndDelimiter ?? "-"
    }
    
    var currencyCode: String {
        loc.currency?.identifier ?? "-"
    }
    
    var currencySymbol: String {
        loc.currencySymbol ?? "-"
    }
    
    var metricSystem: String {
        loc.measurementSystem.identifier
    }
    
    var calendar: String {
        loc.calendar.identifier.debugDescription
    }
    
    var preferredLanguages: [String] {
        Locale.preferredLanguages
    }
    
    init() {
        fetchBuildNumber()
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
