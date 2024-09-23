import SwiftUI

struct AccessibilityParam: Identifiable {
    let id = UUID()
    
    let name: LocalizedStringKey
    let isEnabled: Bool
    
    init(_ name: LocalizedStringKey, isEnabled: Bool) {
        self.name = name
        self.isEnabled = isEnabled
    }
    
    var text: String {
        isEnabled ? "Enabled" : "Disabled"
    }
}
