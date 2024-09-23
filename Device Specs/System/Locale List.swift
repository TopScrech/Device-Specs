import ScrechKit

struct LocaleList: View {
    @Environment(SystemVM.self) private var vm
    
    var body: some View {
        Section("Locale") {
            ListParam("System language", param: vm.language)
            ListParam("Preferred languages", param: vm.preferredLanguages.description)
            
            ListParam("Currency code", param: vm.currencyCode)
            ListParam("Currency symbol", param: vm.currencySymbol)
            
            ListParam("System region", param: vm.region)
            ListParam("Containing region", param: vm.containingRegion)
            ListParam("Subregions", param: vm.subRegions)
            ListParam("ISO region", param: vm.isISORegion)
            ListParam("Continent", param: vm.continent)
            
            ListParam("Numbering system", param: vm.numberingSystem)
            ListParam("Available numbering systems", param: vm.availableNumberingSystems)
            ListParam("Metric system", param: vm.metricSystem)
            ListParam("Calendar", param: vm.calendar)
            ListParam("Hour cycle", param: vm.hourCycle)
            ListParam("First day of week", param: vm.firstDayOfWeek)
            
            ListParam("Collation", param: vm.collation)
            ListParam("Collator identifier", param: vm.collatorIdentifier)
            
            ListParam("Decimal separator", param: vm.decimalSeparator)
            ListParam("Grouping separator", param: vm.groupingSeparator)
            ListParam("Variant", param: vm.variant)
            ListParam("Subdivision", param: vm.subdivision)
            ListParam("Quotation begin delimiter", param: vm.quotationBeginDelimiter)
            ListParam("Quotation end delimiter", param: vm.quotationEndDelimiter)
            ListParam("Alternate quotation begin delimiter", param: vm.alternateQuotationBeginDelimiter)
            ListParam("Alternate quotation end delimiter", param: vm.alternateQuotationEndDelimiter)
        }
    }
}

#Preview {
    List {
        LocaleList()
    }
}
