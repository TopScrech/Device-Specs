import SwiftUI
import SafariCover

@main
struct DeviceSpecsApp: App {
    private var nav = NavState()
    @StateObject private var store = ValueStore()
    
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
        .environmentObject(store)
    }
}
