import ScrechKit

struct Timezone: View {
    private var vm = TimezoneVM()
    
    var body: some View {
        List {
            Section {
                TimelineView(.periodic(from: Date(), by: 1)) { context in
                    VStack(alignment: .leading) {
                        Text(context.date, style: .date)
                            .headline()
                        
                        Text(context.date, format: .dateTime.hour().minute().second())
                            .title3()
                    }
                }
            }
            
            ListParam("Time zone", param: vm.timeZone)
            ListParam("Abbreviation", param: vm.abbreviation)
            ListParam("Seconds from GMT", param: vm.secondsFromGMT)
            
            ListParam("Time zone data version", param: vm.timeZoneDataVersion)
            ListParam("Autoupdating current", param: vm.autoupdatingCurrent)
            
            if vm.isDaylightSavingTime {
                Section("Daylight saving time") {
                    if let date = vm.nextDaylightSavingTimeTransition?.formatted() {
                        ListParam("Next transition", param: date)
                    }
                    
                    ListParam("Time offset", param: vm.daylightSavingTimeOffset)
                }
            }
            
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
