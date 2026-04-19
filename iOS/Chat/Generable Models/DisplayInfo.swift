import FoundationModels

@Generable
@available(iOS 26, *)
struct DisplayInfo {
    @Guide(description: "Display aspect ratio")
    let aspectRatio: String
    
    @Guide(description: "Display refresh rate")
    let refreshRate: String
    
    @Guide(description: "Display diagonal size, represented in inches")
    let diagonalSize: String
    
    @Guide(description: "Display pixel density, represented in PPI (pixels per inch)")
    let pixelDencity: String?
    
    @Guide(description: "Display resolution, represented in pixels")
    let resolution: String
    
    @Guide(description: "Display with rounded or sharp corners")
    let roundedCorners: Bool
}
