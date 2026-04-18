import SwiftUI

struct ProcessorSpecs: View {
    @Environment(ProcessorVM.self) private var vm
    
    var body: some View {
        List {
            Section("CPU") {
                LabeledContent("CPU", value: ProcessorVM.cpuName)
                
                LabeledContent("Microarchitecture", value: vm.microArch)
                
                LabeledContent("Technology node", value: ProcessorVM.techNode)
                
                LabeledContent("Architecture", value: vm.arch)
                
                LabeledContent("Core count", value: "\(vm.cores) (\(vm.activeCores) active)")
                
                LabeledContent("Max. clock speed", value: ProcessorVM.clockSpeed)
                
                LabeledContent("Instruction set", value: vm.instructionSet)
                
                LabeledContent("Host name", value: vm.hostName)
                
                LabeledContent("Thread count", value: vm.threadCount)
                
                NavigationLink("Current process") {
                    CurrentProcess()
                        .environment(vm)
                }
            }
            
            Section("Neural Engine") {
                LabeledContent("Core count", value: vm.neuralEngineCores)
                LabeledContent("TOPS", value: vm.neuralEngineTOPS)
            }
            
#if !os(watchOS)
            Section("GPU") {
                if let device = MTLCreateSystemDefaultDevice() {
                    LabeledContent("GPU", value: device.name)
                    
                    LabeledContent("Architecture", value: device.architecture.name)
                    
                    LabeledContent("Unified memory", value: device.hasUnifiedMemory ? "Yes" : "No")
                    
                    LabeledContent("Raytracing", value: device.supportsRaytracing ? "Supported" : "Unsupported")
                    
                    NavigationLink("Supported GPU families") {
                        GPUFamilies()
                    }
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
    NavigationStack {
        ProcessorSpecs()
    }
    .environment(ProcessorVM())
    .darkSchemePreferred()
}
