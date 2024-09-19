import ScrechKit

struct SystemSpecs: View {
    @Environment(SystemVM.self) private var vm
    
    var body: some View {
        List {
            ListParameter("Operating system", parameter: vm.operatingSystem)
            ListParameter("Build number", parameter: vm.buildNumber)
            ListParameter("Multitasking", parameter: vm.multitaskingSupported)
            
            Section("Current session") {
                ListParameter("Active time", parameter: vm.fetchSystemActiveTime())
                ListParameter("System uptime", parameter: vm.fetchSystemUptime())
            }
            
            Section("Language & Region") {
                ListParameter("System region", parameter: vm.region)
                ListParameter("System language", parameter: vm.language)
            }
        }
        .navigationTitle("System")
    }
}

#Preview {
    SystemSpecs()
        .environment(SystemVM())
}
