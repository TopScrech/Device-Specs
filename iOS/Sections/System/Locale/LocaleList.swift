import SwiftUI

struct LocaleList: View {
    private var vm = LocaleVM()
    
    var body: some View {
        List {
            Section {
                LabeledContent("System language", value: vm.language)
                
                HStack(alignment: .top) {
                    Text("Preferred languages")
                    
                    Spacer()
                    
                    VStack {
                        ForEach(vm.preferredLangs, id: \.self) {
                            Text($0)
                        }
                    }
                    .secondary()
                }
            }
            
            Section {
                LabeledContent("Currency code", value: vm.currencyCode)
                LabeledContent("Currency symbol", value: vm.currencySymbol)
            }
            
            Section {
                LabeledContent("System region", value: vm.region)
                LabeledContent("Containing region", value: vm.containingRegion)
                LabeledContent("Subregions", value: vm.subRegions)
                LabeledContent("ISO region", value: vm.isISORegion.yesOrNo())
                LabeledContent("Continent", value: vm.continent)
            }
            
            Section {
                LabeledContent("Numbering system", value: vm.numberingSystem)
                                
                HStack {
                    Text("Available numbering systems")
                    
                    Spacer()
                    
                    VStack {
                        ForEach(vm.availableNumberingSystems, id: \.self) {
                            Text($0.debugDescription)
                                .secondary()
                        }
                    }
                }
                
                LabeledContent("Metric system", value: vm.metricSystem)
                LabeledContent("Calendar", value: vm.calendar)
                LabeledContent("Hour cycle", value: vm.hourCycle)
                LabeledContent("First day of week", value: vm.firstDayOfWeek)
            }
            
            Section {
                LabeledContent("Collation", value: vm.collation)
                LabeledContent("Collator identifier", value: vm.collatorIdentifier)
            }
            
            Section {
                LabeledContent("Decimal separator", value: vm.decimalSeparator)
                LabeledContent("Grouping separator", value: vm.groupingSeparator)
                LabeledContent("Variant", value: vm.variant)
                LabeledContent("Subdivision", value: vm.subdivision)
                LabeledContent("Quotation begin delimiter", value: vm.quotationBeginDelimiter)
                LabeledContent("Quotation end delimiter", value: vm.quotationEndDelimiter)
                LabeledContent("Alternate quotation begin delimiter", value: vm.alternateQuotationBeginDelimiter)
                LabeledContent("Alternate quotation end delimiter", value: vm.alternateQuotationEndDelimiter)
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
