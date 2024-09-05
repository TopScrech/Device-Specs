import SwiftUI

@main
struct DeviceSpecs: App {
    private var navState = NavState()
    
    var body: some Scene {
        WindowGroup {
            AppContainer()
        }
        .environment(navState)
    }
}
