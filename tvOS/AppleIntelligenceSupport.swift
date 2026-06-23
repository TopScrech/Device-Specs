import SwiftUI

#if canImport(ImagePlayground)
import ImagePlayground
#endif

@available(iOS 18.1, *)
struct AppleIntelligenceSupport: View {
#if canImport(ImagePlayground)
    @Environment(\.supportsImagePlayground) private var isSupported
#else
    private let isSupported = false
#endif
    
    var body: some View {
        HStack(spacing: 25) {
            Image(systemName: "siri")
                .foregroundStyle(.primary)
                .symbolRenderingMode(.multicolor)
            
            Text(isSupported ? "Your device supports Image Playground" : "Your device does not support Image Playground")
        }
        .padding(.vertical, 5)
    }
}

@available(iOS 18.1, *)
#Preview {
    List {
        AppleIntelligenceSupport()
    }
    .darkSchemePreferred()
}
