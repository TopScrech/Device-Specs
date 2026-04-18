import SwiftUI

struct SystemSpecs: View {
    @Environment(SystemVM.self) private var vm
    
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        List {
            Section {
                LabeledContent("Operating system", value: SystemVM.operatingSystem)
                LabeledContent("Build", value: vm.buildNumber)
            }
            
            if #available(iOS 18.1, visionOS 2.4, *) {
                Section {
                    AppleIntelligenceSupport()
                    
                    if #available(iOS 26, visionOS 26, *) {
                        FoundationModelsSupport()
                    }
                }
            }
            
            Section {
                LabeledContent("Multitasking", value: vm.multitaskingSupported)
                
                NavigationLink {
                    Timezone()
                } label: {
                    LabeledContent("Time zone", value: vm.timeZone)
                }
                
                NavigationLink {
                    LocaleList()
                } label: {
                    LabeledContent("Locale", value: vm.lang)
                }
                
                NavigationLink {
                    FontList()
                } label: {
                    LabeledContent("System fonts", value: vm.fontCount)
                }
            }
            
            Section("Current session") {
                LabeledContent("Active time", value: vm.systemActiveTime)
                    .animation(.default, value: vm.systemActiveTime)
                
                LabeledContent("System uptime", value: vm.systemUptime)
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
