import FoundationModels

@available(iOS 26, *)
struct GetCameraInfo: Tool {
    let name = "getCameraInfo"
    let description = "Gets information about the camera's of this device"
    
    @Generable
    struct Arguments {}
    
    func call(arguments: Arguments) async throws -> CameraInfo {
        await CameraInfo(
            hasLidar: CameraVM.hasLidar
        )
    }
}
