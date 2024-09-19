import ScrechKit

struct SystemSpecs: View {
    @Environment(SystemVM.self) private var vm
    
    var body: some View {
        List {
            ListParameter("Operating system", parameter: vm.operatingSystem)
            ListParameter("Build number", parameter: vm.buildNumber)
            
            Section("Current session") {
                ListParameter("Active time", parameter: vm.fetchSystemActiveTime())
                ListParameter("System uptime", parameter: vm.fetchSystemUptime())
            }
        }
    }
}

#Preview {
    SystemSpecs()
        .environment(SystemVM())
}
