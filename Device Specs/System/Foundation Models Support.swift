import SwiftUI

#if canImport(FoundationModels)
import FoundationModels
#endif

struct FoundationModelsSupport: View {
    private var isSupported: Bool {
#if canImport(FoundationModels)
        SystemLanguageModel.default.isAvailable
#else
        false
#endif
    }
    
    var body: some View {
        Label {
            Text(
                isSupported
                ? "Your device supports Foundation Models"
                : "Your device does not support Foundation Models"
            )
        } icon: {
            Image(.foundationModels)
                .resizable()
                .frame(32)
        }
        .padding(.vertical, 5)
        .opacity(isSupported ? 1 : 0.5)
#if os(tvOS)
        .labelReservedIconWidth(64)
#endif
    }
}

#Preview {
    List {
        FoundationModelsSupport()
    }
    .darkSchemePreferred()
}
