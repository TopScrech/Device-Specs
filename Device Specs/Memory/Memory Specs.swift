import ScrechKit

struct MemorySpecs: View {
    @Environment(MemoryVM.self) private var vm
    
    var body: some View {
        List {
            Section("RAM") {
                ListParam("Total", param: vm.totalRam)
                ListParam("Used", param: vm.usedRam)
                ListParam("Free", param: vm.freeRam)
            }
            
            ListParam("SDRAM", param: vm.memoryType)
            
            Section("Storage") {
                ListParam("Total", param: vm.totalDisk)
                ListParam("Used", param: vm.usedDisk)
                
#if os(watchOS) || os(tvOS)
                ListParam("Free", param: vm.freeDisk)
#else
                DisclosureGroup {
                    ListParam("Available for opportunistic usage", param: vm.freeDiskForOpportunisticUsage)
                    
                    ListParam("Available for important usage", param: vm.freeDiskForImportantUsage)
                } label: {
                    ListParam("Free", param: vm.freeDisk)
                }
#endif
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
