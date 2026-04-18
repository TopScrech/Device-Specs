import SwiftUI
import DeviceKit

@Observable
final class DisplayVM {
    static let diagonalSize = "\(Device.current.diagonal)\""
    
    static var pixelDencity: String? {
        guard let ppi = Device.current.ppi else {
            return ""
        }
        
        return "\(ppi) PPI"
    }
    
    static var resolution: String {
#if os(watchOS)
        let screenBounds = WKInterfaceDevice.current().screenBounds
        let screenScale = WKInterfaceDevice.current().screenScale
#else
        let screenBounds = UIScreen.main.bounds
        let screenScale = UIScreen.main.scale
#endif
        let screenWidth = Int(screenBounds.size.width * screenScale)
        let screenHeight = Int(screenBounds.size.height * screenScale)
        
        return "\(screenWidth) x \(screenHeight)"
    }
    
#if !os(watchOS)
    static var refreshRate = String(UIScreen.main.maximumFramesPerSecond)
#endif
    
#if os(iOS)
    let isRounded = Device.current.hasRoundedDisplayCorners ? "Yes" : "No"
#endif
    
    static var aspectRatio: String {
        let screenRatio = Device.current.screenRatio
        return "\(screenRatio.height) : \(screenRatio.width)"
    }
}
