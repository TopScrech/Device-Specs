import SwiftUI
import DeviceKit
import MediaAccessibility

struct AccessibilitySpecs: View {
    @State private var vm = AccessibilityVM()
    
    var body: some View {
        List {
            ForEach(vm.filteredParams) {
                AccessibilityItem($0)
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
