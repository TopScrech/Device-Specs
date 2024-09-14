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
            ListParameter(param.name, parameter: param.text)
        }
#else
        ListParameter(param.name, parameter: param.text)
#endif
    }
}

#Preview {
    AccessibilityItem(.init("Preview", isEnabled: true))
}
