import SwiftUI
import DeviceKit

@Observable
final class DisplayVM {

#if !os(tvOS)
    static var diagonalSize: String {
#if os(iOS)
        let diagonal = Device.current.diagonal
        return "\(diagonal)\""
#else
        guard let ppi = Device.current.ppi else {
            return ""
        }
        
        let screen = WKInterfaceDevice.current()
        let size = screen.screenBounds.size
        let diagonalPixels = hypot(size.width * screen.screenScale, size.height * screen.screenScale)
        let diagonal = diagonalPixels / Double(ppi)
        
        return "\(diagonal.formatted(.number.precision(.fractionLength(2))))\""
#endif
    }
#endif
    
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
    static let roundedCorners = Device.current.hasRoundedDisplayCorners
#endif
    
    static var aspectRatio: String {
        let screenRatio = Device.current.screenRatio
        return "\(screenRatio.height) : \(screenRatio.width)"
    }
}
