import ScrechKit

struct AccessibilityItem: View {
    private let param: AccessibilityParam
    
    init(_ param: AccessibilityParam) {
        self.param = param
    }
    
    var body: some View {
        ListParam(param.name, param: param.text)
    }
}

#Preview {
    AccessibilityItem(
        .init("Preview", isEnabled: true)
    )
}
