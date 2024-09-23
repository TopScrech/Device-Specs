import SwiftUI
import MediaAccessibility

struct AccessibilityView: View {
    @State private var vm = AccessibilityVM()
    
    var body: some View {
        List {
            if #available(iOS 18, macCatalyst 18, visionOS 2, macOS 15, tvOS 18, *) {
                let name: LocalizedStringKey = "Music Haptics"
                
                if "\(name)".contains(vm.filter) || vm.filter.isEmpty {
                    Section {
                        let isEnabled = MAMusicHapticsManager.shared.isActive
                        let param = AccessibilityParam(name, isEnabled: isEnabled)
                        
                        AccessibilityItem(param)
                    }
                }
            }
            
            ForEach(vm.filteredParams) { param in
                AccessibilityItem(param)
            }
        }
        .animation(.default, value: vm.filter)
        .navigationTitle("Accessibility")
        .searchable(text: $vm.filter)
        .scrollIndicators(.never)
    }
}

#Preview {
    AccessibilityView()
}
