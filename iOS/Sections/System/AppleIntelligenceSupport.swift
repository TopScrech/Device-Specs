import SwiftUI

#if canImport(ImagePlayground)
import ImagePlayground
#endif

@available(iOS 18.1, visionOS 2.4, *)
struct AppleIntelligenceSupport: View {
#if canImport(ImagePlayground)
    @Environment(\.supportsImagePlayground) private var isSupported
#else
    private let isSupported = false
#endif
    
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

@available(iOS 18.1, visionOS 2.4, *)
#Preview {
    List {
        AppleIntelligenceSupport()
    }
    .darkSchemePreferred()
}
