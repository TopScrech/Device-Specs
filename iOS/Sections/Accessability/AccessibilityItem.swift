import SwiftUI

struct AccessibilityItem: View {
    private let param: AccessibilityParam
    
    init(_ param: AccessibilityParam) {
        self.param = param
    }
    
    var body: some View {
        LabeledContent(param.name, value: param.isEnabled.yesOrNo())
    }
}

#Preview {
    List {
        AccessibilityItem(
            .init("Preview", isEnabled: true)
        )
    }
    .darkSchemePreferred()
}
