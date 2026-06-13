import SwiftUI

#if canImport(ImagePlayground)
import ImagePlayground
#endif

@available(iOS 18.1, *)
struct AppleIntelligenceSupportAvailabilityReader: View {
#if canImport(ImagePlayground)
    @Environment(\.supportsImagePlayground) private var isSupported
#else
    private let isSupported = false
#endif
    
    var body: some View {
        AppleIntelligenceSupportRow(isSupported: isSupported)
    }
}
