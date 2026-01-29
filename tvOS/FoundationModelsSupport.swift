import SwiftUI

#if canImport(FoundationModels)
import FoundationModels
#endif

@available(iOS 26, *)
struct FoundationModelsSupport: View {
    private var isSupported: Bool {
#if canImport(FoundationModels)
        SystemLanguageModel.default.isAvailable
#else
        false
#endif
    }
    
    var body: some View {
        HStack(spacing: 25) {
            Image(.foundationModels)
                .resizable()
                .frame(32)
            
            Text(isSupported ? "Your device supports Foundation Models" : "Your device does not support Foundation Models")
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
