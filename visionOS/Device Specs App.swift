import SwiftUI

#if canImport(SafariCover)
import SafariCover
#endif

@main
struct DeviceSpecsApp: App {
    var body: some Scene {
        WindowGroup {
            AppContainer()
        }
    }
}
