import SwiftUI
import DeviceKit

@Observable
final class DisplayVM {
    private(set) var resolution = ""
    private(set) var dencity = ""
    private(set) var diagonalSize = ""
    
    init() {
        fetchScreenResolution()
    }
    
#if !os(watchOS)
    var refreshRate = String(UIScreen.main.maximumFramesPerSecond)
#endif
    
#if os(iOS)
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
        
#if !os(tvOS)
        diagonalSize = "\(Device.current.diagonal)\""
#endif
        guard let ppi = Device.current.ppi else {
            return
        }
        
        dencity = "\(ppi.description) PPI"
    }
}
