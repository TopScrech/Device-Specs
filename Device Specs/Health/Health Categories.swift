import SwiftUI

struct HealthCategories: View {
    @Environment(HealthVM.self) private var vm
    
    var body: some View {
        HealthCategoryLink("Body Measurements", icon: "figure", records: vm.bodyMass)
            .environment(vm)
        
        HealthCategoryLink("Body Measurements", icon: "figure", records: vm.bodyMass)
            .environment(vm)
    }
}

#Preview {
    List {
        HealthCategories()
            .environment(HealthVM())
    }
}
