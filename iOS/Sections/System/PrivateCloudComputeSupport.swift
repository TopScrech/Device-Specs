import SwiftUI

#if canImport(FoundationModels)
import FoundationModels
#endif

struct PrivateCloudComputeSupport: View {
    private var isSupported: Bool {
#if canImport(FoundationModels)
        if #available(anyAppleOS 27, *) {
            PrivateCloudComputeLanguageModel().isAvailable
        } else {
            false
        }
#else
        false
#endif
    }
    
    var body: some View {
        Label {
            Text(isSupported ? "Private Cloud Compute supported" : "Private Cloud Compute supported")
        } icon: {
            Image(systemName: isSupported ? "icloud" : "icloud.slash")
                .foregroundStyle(.primary)
                .symbolRenderingMode(.multicolor)
        }
        .padding(.vertical, 5)
        .opacity(isSupported ? 1 : 0.5)
    }
}

@available(iOS 27, *)
#Preview {
    List {
        PrivateCloudComputeSupport()
    }
    .darkSchemePreferred()
}
