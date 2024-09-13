import ScrechKit

struct AccessibilityView: View {
    @State private var vm = AccessibilityVM()
    
    var body: some View {
        List {
            ForEach(vm.filteredParams) { param in
                ListParameter(param.name, parameter: param.text)
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
