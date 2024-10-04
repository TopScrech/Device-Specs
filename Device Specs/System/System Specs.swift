import ScrechKit

struct SystemSpecs: View {
    @Environment(SystemVM.self) private var vm
    
    var body: some View {
        List {
            Section {
                ListParam("Operating system", param: vm.operatingSystem)
                ListParam("Build number", param: vm.buildNumber)
            }
            
            AppleIntelligenceSupport()
            
            Section {
                ListParam("Multitasking", param: vm.multitaskingSupported)
                
                NavigationLink {
                    Timezone()
                } label: {
                    ListParam("Time zone", param: vm.timeZone)
                }
                
                NavigationLink {
                    LocaleList()
                } label: {
                    ListParam("Locale", param: vm.lang)
                }
                
                NavigationLink {
                    FontList()
                } label: {
                    ListParam("System fonts", param: vm.fontCount)
                }
            }
            
            Section("Current session") {
                ListParam("Active time", param: vm.fetchSystemActiveTime())
                ListParam("System uptime", param: vm.fetchSystemUptime())
            }
        }
        .navigationTitle("System")
    }
}

#Preview {
    SystemSpecs()
        .environment(SystemVM())
}
