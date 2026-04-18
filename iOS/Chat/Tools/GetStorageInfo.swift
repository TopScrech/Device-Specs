import FoundationModels

@available(iOS 26, *)
struct GetStorageInfo: Tool {
    let name = "getStorageInfo"
    let description = "Gets information about the disk storage of this device"
    
    @Generable
    struct Arguments {}
    
    func call(arguments: Arguments) async throws -> StorageInfo {
        let vm = await MemoryVM()
        await vm.getDiskInfo()
        
        return await StorageInfo(
            totalDisk: vm.totalDisk,
            usedDisk: vm.usedDisk,
            freeDisk: vm.freeDisk
        )
    }
}
