import ScrechKit

struct SystemSpecs: View {
    @Environment(SystemVM.self) private var vm
    
    var body: some View {
        List {
            ListParam("Operating system", param: vm.operatingSystem)
            ListParam("Build number", param: vm.buildNumber)
            ListParam("Multitasking", param: vm.multitaskingSupported)
            
            Section("Current session") {
                ListParam("Active time", param: vm.fetchSystemActiveTime())
                ListParam("System uptime", param: vm.fetchSystemUptime())
            }
            
#if !os(tvOS)
            HealthKit()
#endif
            
            LocaleList()
                .environment(vm)
        }
        .navigationTitle("System")
    }
}

#Preview {
    SystemSpecs()
        .environment(SystemVM())
}
