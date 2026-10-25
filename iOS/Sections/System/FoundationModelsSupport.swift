import SwiftUI

#if canImport(FoundationModels) && !os(watchOS)
import FoundationModels
#endif

struct FoundationModelsSupport: View {
    private var isSupported: Bool {
#if canImport(FoundationModels) && !os(watchOS)
        if #available(anyAppleOS 26, *) {
            SystemLanguageModel.default.isAvailable
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
                Text("Foundation Models")
            } icon: {
                Image(.foundationModels)
                    .resizable()
                    .frame(32)
            }
        }
        .padding(.vertical, 5)
        .opacity(isSupported ? 1 : 0.5)
    }
}

@available(iOS 26, *)
#Preview {
    List {
        FoundationModelsSupport()
    }
    .darkSchemePreferred()
}
