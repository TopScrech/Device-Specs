import SwiftUI
import DeviceKit

@Observable
final class DisplayVM {
    var resolution = ""
    var dencity = ""
    var diagonalSize = ""
    
#if !os(watchOS)
    var refreshRate = String(UIScreen.main.maximumFramesPerSecond)
    let isRounded = Device.current.hasRoundedDisplayCorners ? "Yes" : "No"
#endif
    
    var aspectRatio: String {
        let screenRatio = Device.current.screenRatio
        return screenRatio.height.description + " : " + screenRatio.width.description
    }
    
    func fetchScreenResolution() {
#if os(watchOS)
        let screenBounds = WKInterfaceDevice.current().screenBounds
        let screenScale = WKInterfaceDevice.current().screenScale
#else
        let screenBounds = UIScreen.main.bounds
        let screenScale = UIScreen.main.scale
#endif
        let screenWidth = Int(screenBounds.size.width * screenScale)
        let screenHeight = Int(screenBounds.size.height * screenScale)
        
        resolution = "\(screenWidth) x \(screenHeight)"
        
        // Diagonal size in pixels
        let diagonalPixels = sqrt(pow(Double(screenWidth), 2) + pow(Double(screenHeight), 2))
        
        guard let ppi = Device.current.ppi else {
            return
        }
        
        dencity = "\(ppi.description) PPI"
        
        let rounded = round(Double(ppi) / 10) * 10
        print("Rounded \(ppi) to \(rounded)")
        let diagonalInches = diagonalPixels / rounded
        
        diagonalSize = String(format: "%.2f\"", diagonalInches)
    }
}
