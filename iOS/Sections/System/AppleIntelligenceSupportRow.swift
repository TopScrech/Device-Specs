import SwiftUI

struct AppleIntelligenceSupportRow: View {
    let isSupported: Bool
    
    var body: some View {
        Label {
            Text(isSupported ? "Image Playground supported" : "Image Playground not supported")
        } icon: {
            Image(systemName: "siri")
                .foregroundStyle(.primary)
                .symbolRenderingMode(.multicolor)
        }
        .padding(.vertical, 5)
    }
}
