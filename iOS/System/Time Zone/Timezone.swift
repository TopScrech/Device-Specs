import SwiftUI

struct Timezone: View {
    private var vm = TimezoneVM()
    
    var body: some View {
        List {
            ClockView()
            
            LabeledContent("Time zone", value: vm.timeZone)
            LabeledContent("Abbreviation", value: vm.abbreviation)
            LabeledContent("Seconds from GMT", value: vm.secondsFromGMT)
            
            LabeledContent("Time zone data version", value: vm.timeZoneDataVersion)
            LabeledContent("Autoupdating current", value: vm.autoupdatingCurrent)
            
            if vm.isDaylightSavingTime {
                Section("Daylight saving time") {
                    if let date = vm.nextDaylightSavingTimeTransition?.formatted() {
                        LabeledContent("Next transition", value: date)
                    }
                    
                    LabeledContent("Time offset", value: vm.daylightSavingTimeOffset)
                }
            }
            
            Section {
                NavigationLink {
                    KnownTimeZones(vm.knownTimeZones)
                } label: {
                    LabeledContent("Known time zones", value: vm.knownTimeZones.count.description)
                }
            }
        }
        .navigationTitle("Time Zone")
        .scrollIndicators(.never)
    }
}

#Preview {
    NavigationStack {
        Timezone()
    }
    .darkSchemePreferred()
}
