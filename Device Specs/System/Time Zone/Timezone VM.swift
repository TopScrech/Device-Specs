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
    
    var nextDaylightSavingTimeTransition: String {
        time.nextDaylightSavingTimeTransition?.description ?? "-"
    }
    
    var daylightSavingTimeOffset: String {
        time.daylightSavingTimeOffset().description
    }
    
    var isDaylightSavingTime: String {
        time.isDaylightSavingTime() ? "Yes" : "No"
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
