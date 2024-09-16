import ScrechKit
import DeviceKit

struct ProcessorView: View {
    private var vm = ProcessorVM()
    
    var body: some View {
        List {
            Section("CPU") {
#warning("Number of threads")
                //                Button("Test") {
                //                    var threadCount = mach_msg_type_number_t()
                //                    var threadList: thread_act_array_t?
                //                    let kerr = task_threads(mach_task_self_, &threadList, &threadCount)
                //
                //                    if kerr == KERN_SUCCESS {
                //                        print("Number of Threads: \(Int(threadCount))")
                //                    } else {
                //                        print("Hopa")
                //                    }
                //                }
                
                let cpu = Device.current.cpu.description
                ListParameter("CPU", parameter: cpu)
                
                ListParameter("Architecture", parameter: vm.arch)
                
                ListParameter("Core count", parameter: vm.cores.description)
                
                ListParameter("Active core count", parameter: vm.activeCores.description)
            }
            
#if !os(watchOS)
            Section("GPU") {
                if let device = MTLCreateSystemDefaultDevice() {
                    ListParameter("GPU", parameter: device.name)
                    ListParameter("Architecture", parameter: device.architecture.name)
                    ListParameter("Unified memory", parameter: device.hasUnifiedMemory ? "Yes" : "No")
                    ListParameter("Supports raytracing", parameter: device.supportsRaytracing ? "Yes" : "No")
                    
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
    ProcessorView()
}
