import ScrechKit

struct MemorySpecs: View {
    @Environment(MemoryVM.self) private var vm
    
    var body: some View {
        List {
            Section("RAM") {
                ListParam("Total RAM", param: vm.totalRam)
                ListParam("Used RAM", param: vm.usedRam)
                ListParam("Free RAM", param: vm.freeRam)
                ListParam("SDRAM Type", param: vm.memoryType)
            }
            
            Section("Storage") {
                ListParam("Total storage", param: vm.totalDisk)
                ListParam("Used storage", param: vm.usedDisk)
                ListParam("Free storage", param: vm.freeDisk)
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
