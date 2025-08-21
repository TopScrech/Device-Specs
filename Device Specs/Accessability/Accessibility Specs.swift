import SwiftUI
import DeviceKit
import MediaAccessibility

struct AccessibilitySpecs: View {
    @State private var vm = AccessibilityVM()
    
    var body: some View {
        List {
            let name: LocalizedStringKey = "Music Haptics"
            
            if "\(name)".contains(vm.filter) || vm.filter.isEmpty {
                Section {
                    let isEnabled = MAMusicHapticsManager.shared.isActive
                    let param = AccessibilityParam(name, isEnabled: isEnabled)
                    
                    AccessibilityItem(param)
                }
            }
            
            ForEach(vm.filteredParams) { param in
                AccessibilityItem(param)
            }
        }
        .navigationTitle("Accessibility")
        .animation(.default, value: vm.filter)
        .searchable(text: $vm.filter)
        .scrollIndicators(.never)
    }
}

#Preview {
    NavigationStack {
        AccessibilitySpecs()
    }
}
