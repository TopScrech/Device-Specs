import SwiftUI

struct CurrentProcess: View {
    @Environment(ProcessorVM.self) private var vm
    
    var body: some View {
        List {
            LabeledContent("Process name", value: vm.processName)
            
            LabeledContent("Process identifier", value: vm.processIdentifier)
#if os(iOS)
            LabeledContent("Performance profile", value: vm.performanceProfile)
            
            LabeledContent("Sertified for iPhone performance gaming", value: vm.iphonePerformanceGamingSertified)
#endif
            NavigationLink("Environment variables") {
                CurrentProcessEnvironment()
                    .environment(vm)
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
