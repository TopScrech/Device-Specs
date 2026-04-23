import FoundationModels

@available(iOS 26, *)
struct GetCPUInfo: Tool {
    let name = "getCPUInfo"
    let description = "Gets information about the CPU of this device"
    
    @Generable
    struct Arguments {}
    
    func call(arguments: Arguments) async throws -> CPUInfo {
        await CPUInfo(
            name: ProcessorVM.cpuName,
            technode: ProcessorVM.techNode,
            clockSpeed: ProcessorVM.clockSpeed,
            neuralEngineCores: ProcessorVM.neuralEngineCores,
            neuralEngineTOPS: ProcessorVM.neuralEngineTOPS
        )
    }
}
