import ScrechKit
import DeviceKit

struct ProcessorSpecs: View {
    @Environment(ProcessorVM.self) private var vm
    
    var body: some View {
        List {
            Section("CPU") {
                ListParam("CPU", param: vm.cpuName)
                
                ListParam("Technology node", param: "\(vm.techNode) nm")
                
                ListParam("Architecture", param: vm.arch)
                
                ListParam("Core count", param: "\(vm.cores) (\(vm.activeCores) active)")
                
                ListParam("Host name", param: vm.hostName)
                
                ListParam("Thread count", param: vm.threadCount)
                
                NavigationLink {
                    CurrentProcess()
                        .environment(vm)
                } label: {
                    Text("Current process")
                }
            }
            
#if !os(watchOS)
            Section("GPU") {
                if let device = MTLCreateSystemDefaultDevice() {
                    ListParam("GPU", param: device.name)
                    ListParam("Architecture", param: device.architecture.name)
                    ListParam("Unified memory", param: device.hasUnifiedMemory ? "Yes" : "No")
                    ListParam("Supports raytracing", param: device.supportsRaytracing ? "Yes" : "No")
                    
#if os(tvOS)
                    NavigationLink("Supported GPU families") {
                        GPUFamilies(device)
                            .navigationTitle("Supported GPU families")
                    }
#else
                    DisclosureGroup("Supported GPU families") {
                        GPUFamilies(device)
                    }
#endif
                } else {
                    Text("Metal is not supported on this device")
                }
            }
#endif
            
#if os(tvOS)
            NavigationLink("CPU load") {
                CpuUsageChart(vm.cpuUsage)
                    .navigationTitle("CPU load")
            }
#else
            Section("CPU load") {
                CpuUsageChart(vm.cpuUsage)
            }
#endif
        }
        .navigationTitle("Processor")
        .scrollIndicators(.never)
        .refreshableTask {
            vm.cpuUsagePerCore()
        }
    }
}

#Preview {
    ProcessorSpecs()
        .environment(ProcessorVM())
}
