import ScrechKit

struct MemorySpecs: View {
    @Environment(MemoryVM.self) private var vm
    
    var body: some View {
        List {
            Section("RAM") {
                ListParameter("Total RAM", parameter: vm.totalRam)
                ListParameter("Used RAM", parameter: vm.usedRam)
                ListParameter("Free RAM", parameter: vm.freeRam)
            }
            
            Section("Storage") {
                ListParameter("Total storage", parameter: vm.totalDisk)
                ListParameter("Used storage", parameter: vm.usedDisk)
                ListParameter("Free storage", parameter: vm.freeDisk)
            }
        }
        .navigationTitle("Memory")
        .refreshableTask {
            vm.getDiskInfo()
            vm.getMemoryUsage()
        }
    }
}

#Preview {
    MemorySpecs()
        .environment(MemoryVM())
}
