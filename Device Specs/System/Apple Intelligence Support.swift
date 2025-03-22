import SwiftUI

#if canImport(ImagePlayground)
import ImagePlayground
#endif

@available(iOS 18.1, visionOS 2.4, *)
struct AppleIntelligenceSupport: View {
    
#if canImport(ImagePlayground)
    @Environment(\.supportsImagePlayground) private var supportsAppleIntelligence
#else
    private var supportsAppleIntelligence = false
#endif
    
    var body: some View {
        Section {
            Label {
                Text(
                    supportsAppleIntelligence
                    ? "Your device supports Apple Intelligence"
                    : "Your device does not support Apple Intelligence"
                )
            } icon: {
                Image(.appleIntelligence)
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            .opacity(supportsAppleIntelligence ? 1 : 0.1)
            .padding(.vertical, 5)
        }
    }
}

@available(iOS 18.1, visionOS 2.4, *)
#Preview {
    AppleIntelligenceSupport()
}
