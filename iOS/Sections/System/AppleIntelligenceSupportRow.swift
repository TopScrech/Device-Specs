import SwiftUI

struct AppleIntelligenceSupportRow: View {
    let isSupported: Bool
    
    var body: some View {
        LabeledContent {
            Text(isSupported ? "Supported" : "Unsupported")
        } label: {
            Label {
                Text("Image Playground")
            } icon: {
                Image(systemName: "siri")
                    .foregroundStyle(.primary)
                    .symbolRenderingMode(.multicolor)
            }
        }
        .padding(.vertical, 5)
    }
}
