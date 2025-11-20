import SwiftUI

#if canImport(Appearance)
import Appearance
#endif

final class ValueStore: ObservableObject {
#if os(iOS)
    @AppStorage("show_status_bar") var showStatusBar = true
#endif
    
#if canImport(Appearance)
    @AppStorage("appearance") var appearance: Appearance = .system
#endif
}
