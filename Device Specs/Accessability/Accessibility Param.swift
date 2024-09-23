import SwiftUI

struct AccessibilityParam: Identifiable {
    let id = UUID()
    
    let name: LocalizedStringKey
    let isEnabled: Bool?
    
    init(_ name: LocalizedStringKey, isEnabled: Bool? = nil) {
        self.name = name
        self.isEnabled = isEnabled
    }
    
    var text: String {
        if let isEnabled {
            isEnabled ? "Enabled" : "Disabled"
        } else {
            "-"
        }
    }
}
