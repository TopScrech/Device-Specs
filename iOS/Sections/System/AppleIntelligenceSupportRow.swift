import SwiftUI

struct AppleIntelligenceSupportRow: View {
    let isSupported: Bool
    
    private var icon: String {
        isSupported ? "apple.intelligence" : "apple.intelligence.badge.xmark"
    }
    
    var body: some View {
        Label {
            Text(isSupported ? "Image Playground supported" : "Image Playground not supported")
        } icon: {
            Image(systemName: icon)
                .foregroundStyle(.primary)
                .symbolRenderingMode(.multicolor)
        }
        .padding(.vertical, 5)
    }
}
