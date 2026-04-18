import FoundationModels

@available(iOS 26, *)
struct GetSystemInfo: Tool {
    let name = "getSystemInfo"
    let description = "Gets information about the operating system of this device"
    
    @Generable
    struct Arguments {}
    
    func call(arguments: Arguments) async throws -> SystemInfo {
        await SystemInfo(
            os: SystemVM.operatingSystem,
            buildNumber: SystemVM.buildNumber,
            timeZone: SystemVM.timeZone
        )
    }
}
