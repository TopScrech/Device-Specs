import SwiftUI

final class ValueStore: ObservableObject {
#if os(iOS)
    @AppStorage("show_status_bar") var showStatusBar = true
    @AppStorage("appearance") var appearance: ColorTheme = .system
#endif
}
