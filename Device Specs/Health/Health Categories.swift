import SwiftUI

struct HealthCategories: View {
    @Environment(HealthVM.self) private var vm
    
    var body: some View {
        NavigationLink("Body measurements") {
            BodyMeasurementsCategory()
                .environment(vm)
        }
    }
}

#Preview {
    List {
        HealthCategories()
    }
    .environment(HealthVM())
}
