import ScrechKit

struct MemorySpecs: View {
    @Environment(MemoryVM.self) private var vm
    
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        List {
            Section("RAM") {
                ListParam("Total", param: vm.totalRam)
                
                ListParam("Used", param: vm.usedRam)
                    .animation(.default, value: vm.usedRam)
                
                ListParam("Free", param: vm.freeRam)
                    .animation(.default, value: vm.freeRam)
            }
            
            ListParam("SDRAM", param: vm.memoryType)
            
            Section("Storage") {
                ListParam("Total", param: vm.totalDisk)
                
                ListParam("Used", param: vm.usedDisk)
                    .animation(.default, value: vm.usedDisk)
                
#if os(watchOS) || os(tvOS)
                ListParam("Free", param: vm.freeDisk)
                    .animation(.default, value: vm.freeDisk)
#else
                DisclosureGroup {
                    ListParam("Available for important usage", param: vm.freeDiskForImportantUsage)
                        .animation(.default, value: vm.freeDiskForImportantUsage)
                    
                    ListParam("Available for opportunistic usage", param: vm.freeDiskForOpportunisticUsage)
                        .animation(.default, value: vm.freeDiskForOpportunisticUsage)
                } label: {
                    ListParam("Free", param: vm.freeDisk)
                        .animation(.default, value: vm.freeDisk)
                }
                .tint(.secondary)
#endif
            }
        }
        .navigationTitle("Memory")
        .numericTransition()
        .monospacedDigit()
        .onReceive(timer) { _ in
            vm.getMemoryUsage()
            vm.getDiskInfo()
        }
    }
}

#Preview {
    NavigationStack {
        MemorySpecs()
    }
    .environment(MemoryVM())
    .darkSchemePreferred()
}
