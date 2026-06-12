import SwiftUI

struct MemorySpecs: View {
    @Environment(MemoryVM.self) private var vm
    
    var body: some View {
        List {
            Section("RAM") {
                LabeledContent("Total", value: vm.totalRAM)
                
                LabeledContent("Used", value: vm.usedRAM)
                    .animation(.default, value: vm.usedRAM)
                
                LabeledContent("Free", value: vm.freeRAM)
                    .animation(.default, value: vm.freeRAM)
            }
            
            LabeledContent("SDRAM", value: vm.memoryType)
            
            Section("Storage") {
                LabeledContent("Total", value: vm.totalDisk)
                
                LabeledContent("Used", value: vm.usedDisk)
                    .animation(.default, value: vm.usedDisk)
                
#if os(watchOS) || os(tvOS)
                LabeledContent("Free", value: vm.freeDisk)
                    .animation(.default, value: vm.freeDisk)
#else
                DisclosureGroup {
                    LabeledContent("Available for important usage", value: vm.freeDiskForImportantUsage)
                        .animation(.default, value: vm.freeDiskForImportantUsage)
                    
                    LabeledContent("Available for opportunistic usage", value: vm.freeDiskForOpportunisticUsage)
                        .animation(.default, value: vm.freeDiskForOpportunisticUsage)
                } label: {
                    LabeledContent("Free", value: vm.freeDisk)
                        .animation(.default, value: vm.freeDisk)
                }
                .tint(.secondary)
#endif
            }
        }
        .navigationTitle("Memory")
        .numericTransition()
        .monospacedDigit()
        .task {
            while !Task.isCancelled {
                vm.getMemoryUsage()
                vm.getDiskInfo()
                
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
        MemorySpecs()
    }
    .environment(MemoryVM())
    .darkSchemePreferred()
}
