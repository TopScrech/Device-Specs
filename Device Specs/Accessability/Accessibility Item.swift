import ScrechKit

struct AccessibilityItem: View {
    private let param: AccessibilityParam
    
    init(_ param: AccessibilityParam) {
        self.param = param
    }
    
    var body: some View {
#if os(tvOS)
        Button {
            
        } label: {
            ListParam(param.name, param: param.text)
        }
#else
        ListParam(param.name, param: param.text)
#endif
    }
}

#Preview {
    AccessibilityItem(.init("Preview", isEnabled: true))
}
