import FoundationModels

@available(iOS 26, *)
struct GetDeviceInfo: Tool {
    let name = "getDeviceInfo"
    let description = "Gets information about this device"
    
    @Generable
    struct Arguments {}
    
    func call(arguments: Arguments) async throws -> DeviceInfo {
        await DeviceInfo(
            name: DeviceVM.deviceIdentifier,
            bluetoothVersion: DeviceVM.bluetoothVersion
        )
    }
}
