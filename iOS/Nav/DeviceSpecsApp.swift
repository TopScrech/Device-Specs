import SwiftUI

@main
struct DeviceSpecsApp: App {
#if os(iOS)
    @UIApplicationDelegateAdaptor(DeviceSpecsAppDelegate.self) private var appDelegate
#endif
    
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
