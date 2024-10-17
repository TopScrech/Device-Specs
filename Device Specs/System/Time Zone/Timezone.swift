import ScrechKit

struct Timezone: View {
    private var vm = TimezoneVM()
    
    var body: some View {
        List {
            ListParam("Time zone", param: vm.timeZone)
            ListParam("Abbreviation", param: vm.abbreviation)
            ListParam("Seconds from GMT", param: vm.secondsFromGMT)
            
            if let date = vm.nextDaylightSavingTimeTransition?.formatted() {
                ListParam("Next daylight saving time transition", param: date)
            }
            
            ListParam("Is daylight saving time", param: vm.isDaylightSavingTime)
            ListParam("Daylight saving time offset", param: vm.daylightSavingTimeOffset)
            ListParam("Time zone data version", param: vm.timeZoneDataVersion)
            ListParam("Autoupdating current", param: vm.autoupdatingCurrent)
            
            Section {
                NavigationLink {
                    KnownTimeZones(vm.knownTimeZones)
                } label: {
                    ListParam("Known time zones", param: vm.knownTimeZones.count.description)
                }
            }
        }
        .navigationTitle("Time Zone")
        .scrollIndicators(.never)
    }
}

#Preview {
    Timezone()
}
