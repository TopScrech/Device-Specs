import SwiftUI

struct HealthSpecs: View {
    @State private var vm = HealthVM()
    
    var body: some View {
        List {
            HealthAvailability()
            
            HealthCategories()
                .environment(vm)
        }
    }
}

//            HealthRecordsLink("Body Mass", icon: "figure", records: vm.bodyMass)

#Preview {
    HealthSpecs()
}
