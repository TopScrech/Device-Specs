import ScrechKit

struct SystemSpecs: View {
    @Environment(SystemVM.self) private var vm
    
    var body: some View {
        List {
            Section {
                ListParam("Operating system", param: vm.operatingSystem)
                ListParam("Build number", param: vm.buildNumber)
            }
            
            Section {
                ListParam("Multitasking", param: vm.multitaskingSupported)
                
                NavigationLink {
                    Timezone()
                } label: {
                    ListParam("Time zone", param: TimeZone.current.abbreviation() ?? "")
                }
                
                NavigationLink {
                    LocaleList()
                } label: {
                    ListParam("Locale", param: Locale.current.identifier)
                }
                
                NavigationLink {
                    FontList()
                } label: {
                    ListParam("System fonts", param: UIFont.familyNames.count.description)
                }
            }
            
            Section("Current session") {
                ListParam("Active time", param: vm.fetchSystemActiveTime())
                ListParam("System uptime", param: vm.fetchSystemUptime())
            }
            
#if !os(tvOS)
            HealthKit()
#endif
        }
        .navigationTitle("System")
    }
}

#Preview {
    SystemSpecs()
        .environment(SystemVM())
}
