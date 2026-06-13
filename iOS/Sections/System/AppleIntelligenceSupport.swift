import SwiftUI

struct AppleIntelligenceSupport: View {
    var body: some View {
        if #available(iOS 18.1, *) {
            AppleIntelligenceSupportAvailabilityReader()
        } else {
            AppleIntelligenceSupportRow(isSupported: false)
        }
    }
}

#Preview {
    List {
        AppleIntelligenceSupport()
    }
    .darkSchemePreferred()
}
