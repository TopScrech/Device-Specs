import SwiftUI

#if canImport(ImagePlayground)
import ImagePlayground
#endif

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
            Text(
                isSupported
                ? "Your device supports Apple Intelligence"
                : "Your device does not support Apple Intelligence"
            )
        } icon: {
            Image(systemName: icon)
                .foregroundStyle(.primary)
                .symbolRenderingMode(.multicolor)
        }
        .padding(.vertical, 5)
#if os(tvOS)
        .labelReservedIconWidth(64)
#endif
    }
}

#Preview {
    List {
        AppleIntelligenceSupport()
    }
    .darkSchemePreferred()
}
