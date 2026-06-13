import SwiftUI

struct AppleIntelligenceSupportRow: View {
    let isSupported: Bool
    
    private var icon: String {
        isSupported ? "apple.intelligence" : "apple.intelligence.badge.xmark"
    }
    
    var body: some View {
        Label {
            Text(isSupported ? "Your device supports Image Playground" : "Your device does not support Image Playground")
        } icon: {
            Image(systemName: icon)
                .foregroundStyle(.primary)
                .symbolRenderingMode(.multicolor)
        }
        .padding(.vertical, 5)
    }
}
