import Foundation

struct ColorTest: Identifiable {
    let id = UUID()
    let name: LocalizedStringKey
    let color: Color
}
