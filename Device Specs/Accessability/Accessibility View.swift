import SwiftUI

struct AccessibilityView: View {
    @State private var vm = AccessibilityVM()
    
    var body: some View {
        List {
            ForEach(vm.filteredParams) { param in
                AccessibilityItem(param)
            }
        }
        .navigationTitle("Accessibility")
        .searchable(text: $vm.filter)
        .scrollIndicators(.never)
    }
}

#Preview {
    AccessibilityView()
}
