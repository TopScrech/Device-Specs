import ScrechKit

struct CurrentProcess: View {
    @Environment(ProcessorVM.self) private var vm
    
    var body: some View {
        List {
            ListParameter("Process name", parameter: vm.processName)
            
            ListParameter("Process identifier", parameter: vm.processIdentifier)
            
            ListParameter("Globally unique string", parameter: vm.globallyUniqueString)
            
            ListParameter("Arguments", parameter: vm.arguments)
            
            ListParameter("Environment", parameter: vm.environment)
#if os(iOS)
            ListParameter("Performance profile", parameter: vm.performanceProfile)
            
            ListParameter("Sertified for iPhone performance gaming", parameter: vm.sertifiedForIphonePerformanceGaming)
#endif
        }
        .navigationTitle("Current process")
    }
}

#Preview {
    CurrentProcess()
        .environment(ProcessorVM())
}
