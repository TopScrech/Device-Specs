import Foundation
import Device

extension DeviceVM {
    static let announcementDate = dateDescription(Device.current.announcementDate)
    static let releaseDate = dateDescription(Device.current.releaseDate)

    static func dateDescription(_ date: DeviceDate?, locale: Locale = .current) -> String {
        guard let date, let timeZone = TimeZone(secondsFromGMT: 0) else { return "Unknown" }
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timeZone
        let components = DateComponents(year: date.year, month: date.month, day: date.day)
        guard let value = calendar.date(from: components) else { return "Unknown" }
        let format = Date.FormatStyle(date: .long, time: .omitted, locale: locale,
                                      calendar: calendar, timeZone: timeZone)
        return value.formatted(format)
    }
}
