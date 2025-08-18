import SwiftUI
import SafariCover

@main
struct DeviceSpecsApp: App {
    private var nav = NavState()
    
    init() {
#if canImport(MetricKit) && !os(tvOS)
        _ = MetricKitManager.shared
#endif
    }
    
    var body: some Scene {
        WindowGroup {
            AppContainer()
        }
        .environment(nav)
    }
}
