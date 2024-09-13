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
            
            Section("GPU") {
                if let device = MTLCreateSystemDefaultDevice() {
                    ListParameter("GPU", parameter: device.name)
                    ListParameter("Architecture", parameter: device.architecture.name)
                    ListParameter("Unified memory", parameter: device.hasUnifiedMemory ? "Yes" : "No")
                    ListParameter("Supports raytracing", parameter: device.supportsRaytracing ? "Yes" : "No")
                    
                    DisclosureGroup("Supported GPU families") {
                        ListParameter("Apple 1", parameter: device.supportsFamily(.apple1) ? "Yes" : "No")
                        ListParameter("Apple 2", parameter: device.supportsFamily(.apple2) ? "Yes" : "No")
                        ListParameter("Apple 3", parameter: device.supportsFamily(.apple3) ? "Yes" : "No")
                        ListParameter("Apple 4", parameter: device.supportsFamily(.apple4) ? "Yes" : "No")
                        ListParameter("Apple 5", parameter: device.supportsFamily(.apple5) ? "Yes" : "No")
                        ListParameter("Apple 6", parameter: device.supportsFamily(.apple6) ? "Yes" : "No")
                        ListParameter("Apple 7", parameter: device.supportsFamily(.apple7) ? "Yes" : "No")
                        ListParameter("Apple 8", parameter: device.supportsFamily(.apple8) ? "Yes" : "No")
                        ListParameter("Apple 9", parameter: device.supportsFamily(.apple9) ? "Yes" : "No")
                        ListParameter("Common 1", parameter: device.supportsFamily(.common1) ? "Yes" : "No")
                        ListParameter("Common 2", parameter: device.supportsFamily(.common2) ? "Yes" : "No")
                        ListParameter("Common 3", parameter: device.supportsFamily(.common3) ? "Yes" : "No")
                        ListParameter("Mac 2", parameter: device.supportsFamily(.mac2) ? "Yes" : "No")
                        ListParameter("Metal 3", parameter: device.supportsFamily(.metal3) ? "Yes" : "No")
                    }
                } else {
                    Text("Metal is not supported on this device")
                }
            }
            
            Section("CPU load") {
                CpuUsageChart(vm.cpuUsage)
            }
        }
        .navigationTitle("Processor")
        .refreshableTask {
            vm.cpuUsagePerCore()
        }
    }
}

#Preview {
    ProcessorView()
}
