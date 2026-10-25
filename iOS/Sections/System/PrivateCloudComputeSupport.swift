import SwiftUI

#if canImport(FoundationModels) && !os(tvOS) && !os(watchOS)
import FoundationModels
#endif

struct PrivateCloudComputeSupport: View {
    private var isSupported: Bool {
#if canImport(FoundationModels) && !os(tvOS) && !os(watchOS)
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
        LabeledContent {
            Text(isSupported ? "Supported" : "Unsupported")
        } label: {
            Label {
                Text("Private Cloud Compute")
            } icon: {
                Image(systemName: isSupported ? "icloud" : "icloud.slash")
                    .foregroundStyle(.primary)
                    .symbolRenderingMode(.multicolor)
            }
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
