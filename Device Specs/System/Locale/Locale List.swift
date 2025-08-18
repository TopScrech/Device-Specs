import ScrechKit

struct LocaleList: View {
    private var vm = LocaleVM()
    
    var body: some View {
        List {
            Section {
                ListParam("System language", param: vm.language)
                
                HStack(alignment: .top) {
                    Text("Preferred languages")
                    
                    Spacer()
                    
                    VStack {
                        ForEach(vm.preferredLanguages, id: \.self) { lan in
                            Text(lan)
                        }
                    }
                    .secondary()
                }
            }
            
            Section {
                ListParam("Currency code", param: vm.currencyCode)
                ListParam("Currency symbol", param: vm.currencySymbol)
            }
            
            Section {
                ListParam("System region", param: vm.region)
                ListParam("Containing region", param: vm.containingRegion)
                ListParam("Subregions", param: vm.subRegions)
                ListParam("ISO region", param: vm.isISORegion)
                ListParam("Continent", param: vm.continent)
            }
            
            Section {
                ListParam("Numbering system", param: vm.numberingSystem)
                                
                HStack {
                    Text("Available numbering systems")
                    
                    Spacer()
                    
                    VStack {
                        ForEach(vm.availableNumberingSystems, id: \.self) { num in
                            Text(num.debugDescription)
                                .secondary()
                        }
                    }
                }
                
                ListParam("Metric system", param: vm.metricSystem)
                ListParam("Calendar", param: vm.calendar)
                ListParam("Hour cycle", param: vm.hourCycle)
                ListParam("First day of week", param: vm.firstDayOfWeek)
            }
            
            Section {
                ListParam("Collation", param: vm.collation)
                ListParam("Collator identifier", param: vm.collatorIdentifier)
            }
            
            Section {
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
        .navigationTitle("Locale")
        .scrollIndicators(.never)
    }
}

#Preview {
    NavigationStack {
        LocaleList()
    }
    .darkSchemePreferred()
}
