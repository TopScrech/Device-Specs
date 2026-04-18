import FoundationModels

@available(iOS 26, *)
struct GetDisplayInfo: Tool {
    let name = "getDisplayInfo"
    let description = "Gets information about the display of this device"
    
    @Generable
    struct Arguments {}
    
    func call(arguments: Arguments) async throws -> DisplayInfo {
        await DisplayInfo(
            aspectRatio: DisplayVM.aspectRatio,
            refreshRate: DisplayVM.refreshRate
        )
    }
}
