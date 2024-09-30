import ScrechKit

struct CurrentProcess: View {
    @Environment(ProcessorVM.self) private var vm
    
    var body: some View {
        List {
            ListParam("Process name", param: vm.processName)
            
            ListParam("Process identifier", param: vm.processIdentifier)
            
            ListParam("Globally unique string", param: vm.globallyUniqueString)
            
            ListParam("Arguments", param: vm.arguments)
            
            NavigationLink("Environment variables") {
                CurrentProcessEnvironment()
                    .environment(vm)
            }
            
#if os(iOS)
            ListParam("Performance profile", param: vm.performanceProfile)
            
            ListParam("Sertified for iPhone performance gaming", param: vm.sertifiedForIphonePerformanceGaming)
#endif
        }
        .navigationTitle("Current process")
    }
}

#Preview {
    CurrentProcess()
        .environment(ProcessorVM())
}
