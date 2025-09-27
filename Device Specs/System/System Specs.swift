import ScrechKit

struct SystemSpecs: View {
    @Environment(SystemVM.self) private var vm
    
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        List {
            Section {
                ListParam("Operating system", param: vm.operatingSystem)
                ListParam("Build", param: vm.buildNumber)
            }
            
            if #available(iOS 18.1, *) {
                Section {
                    AppleIntelligenceSupport()
                    
                    if #available(iOS 26, *) {
                        FoundationModelsSupport()
                    }
                }
            }
            
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
                ListParam("Active time", param: vm.systemActiveTime)
                    .animation(.default, value: vm.systemActiveTime)
                
                ListParam("System uptime", param: vm.systemUptime)
                    .animation(.default, value: vm.systemUptime)
            }
            .monospacedDigit()
            .numericTransition()
        }
        .navigationTitle("System")
        .task {
            vm.fetchSystemActiveTime()
            vm.fetchSystemUptime()
        }
        .onReceive(timer) { _ in
            vm.fetchSystemActiveTime()
            vm.fetchSystemUptime()
        }
    }
}

#Preview {
    NavigationStack {
        SystemSpecs()
    }
    .environment(SystemVM())
    .darkSchemePreferred()
}
