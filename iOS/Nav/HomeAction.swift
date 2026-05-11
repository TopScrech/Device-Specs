import SwiftUI

enum HomeAction {
    case openAssistant
    
#if os(iOS)
    init?(shortcutItem: UIApplicationShortcutItem) {
        switch shortcutItem.type {
        case Self.openAssistantType:
            self = .openAssistant
            
        default:
            return nil
        }
    }
#endif
    
    private static var openAssistantType: String {
        "\(Bundle.main.bundleIdentifier ?? "dev.topscrech.Device-Specs").openAssistant"
    }
}
