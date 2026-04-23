import FoundationModels

@Generable
@available(iOS 26, *)
struct CameraInfo {
    @Guide(description: "LiDAR capability")
    let hasLidar: Bool
}
