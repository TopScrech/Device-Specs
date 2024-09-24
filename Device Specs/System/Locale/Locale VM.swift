import Foundation

@Observable
final class LocaleVM {
    private let loc = Locale.current
    
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
}
