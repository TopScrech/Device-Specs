import FoundationModels
@preconcurrency import DeviceKit

@available(iOS 26, *)
struct GetCPUInfo: Tool {
    let name = "getCPUInfo"
    let description = "Gets information about the CPU of this device"
    
    @Generable
    struct Arguments {}
    
    func call(arguments: Arguments) async throws -> CPUInfo {
        await CPUInfo(
            name: Device.current.cpu.description,
            technode: Device.current.cpu.techNode
        )
    }
}
