import SwiftUI
import SafariCover

@main
struct DeviceSpecsApp: App {
    private var navState = NavState()
    
    var body: some Scene {
        WindowGroup {
            AppContainer()
        }
        .environment(navState)
    }
}
