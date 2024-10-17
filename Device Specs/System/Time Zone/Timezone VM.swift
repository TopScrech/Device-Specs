import Foundation

@Observable
final class TimezoneVM {
    private let time = TimeZone.current
    
    var timeZone: String {
        time.identifier
    }
    
    var abbreviation: String {
        time.abbreviation() ?? "-"
    }
    
    var secondsFromGMT: String {
        time.secondsFromGMT().description
    }
    
    var nextDaylightSavingTimeTransition: Date? {
        time.nextDaylightSavingTimeTransition
    }
    
    var isDaylightSavingTime: Bool {
        time.isDaylightSavingTime()
    }
    
    var daylightSavingTimeOffset: String {
        let offset = time.daylightSavingTimeOffset()
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 4
        
        if let formattedString = formatter.string(from: offset) {
            return formattedString
        } else {
            return "-"
        }
    }
    
    var timeZoneDataVersion: String {
        TimeZone.timeZoneDataVersion
    }
    
    var autoupdatingCurrent: String {
        TimeZone.autoupdatingCurrent.identifier
    }
    
    var knownTimeZones: [String] {
        TimeZone.knownTimeZoneIdentifiers
    }
}
