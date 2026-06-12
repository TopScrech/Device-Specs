import SwiftUI

struct SystemSpecs: View {
    @Environment(SystemVM.self) private var vm
    
    var body: some View {
        List {
            Section {
                LabeledContent("Operating system", value: SystemVM.operatingSystem)
                LabeledContent("Build", value: SystemVM.buildNumber)
            }
            
            if #available(iOS 18.1, *) {
                Section {
                    AppleIntelligenceSupport()
                    
                    if #available(iOS 26, *) {
                        FoundationModelsSupport()
                    }
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
            
            Section {
                LabeledContent("Multitasking", value: vm.multitaskingSupported.yesOrNo())
                
                NavigationLink {
                    Timezone()
                } label: {
                    LabeledContent("Time zone", value: SystemVM.timeZone ?? "-")
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
        }
        .navigationTitle("System")
        .task {
            while !Task.isCancelled {
                vm.fetchSystemActiveTime()
                vm.fetchSystemUptime()
                
                do {
                    try await Task.sleep(for: .seconds(1))
                } catch {
                    break
                }
            }
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
