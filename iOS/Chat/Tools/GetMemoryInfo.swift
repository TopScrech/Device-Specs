import FoundationModels

@available(iOS 26, *)
struct GetMemoryInfo: Tool {
    let name = "getMemoryInfo"
    let description = "Gets information about the memory (RAM) of this device"
    
    @Generable
    struct Arguments {}
    
    func call(arguments: Arguments) async throws -> MemoryInfo {
        let vm = await MemoryVM()
        
        return await MemoryInfo(
            totalRAM: vm.totalRAM,
            usedRAM: vm.usedRAM,
            freeRAM: vm.freeRAM
        )
    }
}
