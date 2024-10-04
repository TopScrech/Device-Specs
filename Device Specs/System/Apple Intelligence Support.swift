import SwiftUI

struct AppleIntelligenceSupport: View {
    @Environment(SystemVM.self) private var vm
    
    var body: some View {
#warning("Enable after Apple Intelligence release")
#if DEBUG
        Section {
            Label {
                let text: LocalizedStringKey = vm.supportsAppleIntelligence
                ? "Your device supports Apple Intelligence"
                : "Your device does not support Apple Intelligence"
                
                Text(text)
            } icon: {
                Image(.appleIntelligence)
                    .resizable()
                    .frame(width: 32, height: 32)
            }
            .opacity(vm.supportsAppleIntelligence ? 1 : 0.1)
            .padding(.vertical, 5)
        }
#endif
    }
}

#Preview {
    AppleIntelligenceSupport()
        .environment(SystemVM())
}
