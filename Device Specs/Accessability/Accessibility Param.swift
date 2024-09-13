import Foundation

struct AccessibilityParam: Identifiable {
    let id = UUID()
    
    let name: String
    let isEnabled: Bool
    
    init(_ name: String, isEnabled: Bool) {
        self.name = name
        self.isEnabled = isEnabled
    }
    
    var text: String {
        isEnabled ? "Enabled" : "Disabled"
    }
}
