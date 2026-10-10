import SwiftUI

#if canImport(Appearance)
import Appearance
#endif

final class ValueStore: ObservableObject {
    static let shared = ValueStore()

    @AppStorage("debug_mode") var debugMode = false

    static func debugValue<Value>(_ liveValue: @autoclosure () -> Value, override: Value) -> Value {
#if os(iOS)
        shared.debugMode ? override : liveValue()
#else
        liveValue()
#endif
    }

#if os(iOS)
    @AppStorage("show_status_bar") var showStatusBar = true
#endif
    
#if canImport(Appearance)
    @AppStorage("appearance") var appearance: Appearance = .system
#endif
}
