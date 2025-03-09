import SwiftUI

struct ColorTest: Identifiable {
    let id = UUID()
    let name: LocalizedStringKey
    let color: Color
    
    init(_ name: LocalizedStringKey, color: Color) {
        self.name = name
        self.color = color
    }
}
