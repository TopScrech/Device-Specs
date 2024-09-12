import SwiftUI

@Observable
final class DisplayVM {
    var refreshRate = String(UIScreen.main.maximumFramesPerSecond)
    
    func fetchScreenResolution() -> String {
        let screenBounds = UIScreen.main.bounds
        let screenScale = UIScreen.main.scale
        let screenWidth = Int(screenBounds.size.width * screenScale)
        let screenHeight = Int(screenBounds.size.height * screenScale)
        
        return "\(screenWidth) x \(screenHeight)"
    }
}
