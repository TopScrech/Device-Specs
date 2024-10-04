import ScrechKit

struct SystemSpecs: View {
    @Environment(SystemVM.self) private var vm
    
    var body: some View {
        List {
            Section {
                ListParam("Operating system", param: vm.operatingSystem)
                ListParam("Build number", param: vm.buildNumber)
            }
            
#warning("Enable after Apple Intelligence release")
#if DEBUG
            Section {
                Label {
                    let text: LocalizedStringKey = vm.supportsAppleIntelligence
                    ? "Your device supports Apple Intelligence"
                    : "Your device does not support Apple Intelligence"
                    
                    Text(text)
                } icon: {
                    Image(.appleIntelligence)
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                .opacity(vm.supportsAppleIntelligence ? 1 : 0.1)
                .padding(.vertical, 5)
            }
#endif
            
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
            
            HealthKit()
        }
        .navigationTitle("System")
    }
}

#Preview {
    SystemSpecs()
        .environment(SystemVM())
}
