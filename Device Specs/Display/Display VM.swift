import SwiftUI
import DeviceKit

@Observable
final class DisplayVM {
    var resolution = ""
    var refreshRate = String(UIScreen.main.maximumFramesPerSecond)
    
    var aspectRatio: String {
        let screenRatio = Device.current.screenRatio
        return screenRatio.height.description + " : " + screenRatio.width.description
    }
    
    func fetchScreenResolution() {
        let screenBounds = UIScreen.main.bounds
        let screenScale = UIScreen.main.scale
        let screenWidth = Int(screenBounds.size.width * screenScale)
        let screenHeight = Int(screenBounds.size.height * screenScale)
        
        resolution = "\(screenWidth) x \(screenHeight)"
    }
}
