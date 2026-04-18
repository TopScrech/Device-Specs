import FoundationModels

@Generable
@available(iOS 26, *)
struct DisplayInfo {
    @Guide(description: "Aspect ratio of the display of this device")
    let aspectRatio: String
    
    @Guide(description: "Refresh rate of the display of this device")
    let refreshRate: String
}
