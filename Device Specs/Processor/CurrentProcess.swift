import ScrechKit

struct CurrentProcess: View {
    @Environment(ProcessorVM.self) private var vm
    
    var body: some View {
        List {
            ListParam("Process name", param: vm.processName)
            
            ListParam("Process identifier", param: vm.processIdentifier)
#if os(iOS)
            ListParam("Performance profile", param: vm.performanceProfile)
            
            ListParam("Sertified for iPhone performance gaming", param: vm.iphonePerformanceGamingSertified)
#endif
            NavigationLink("Environment variables") {
                CurrentProcessEnvironment()
                    .environment(vm)
            }
            
            Section("Globally unique string") {
                Text(vm.globallyUniqueString)
            }
            
            Section("Arguments") {
                ForEach(vm.arguments, id: \.self) {
                    Text($0)
                }
            }
        }
        .navigationTitle("Current process")
    }
}

#Preview {
    NavigationStack {
        CurrentProcess()
    }
    .environment(ProcessorVM())
    .darkSchemePreferred()
}
