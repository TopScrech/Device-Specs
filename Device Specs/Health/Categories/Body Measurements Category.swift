import SwiftUI

struct BodyMeasurementsCategory: View {
    @Environment(HealthVM.self) private var vm
    
    var body: some View {
        List {
            HealthRecordsLink("Weight", records: vm.bodyMass)
            //        HealthLink("Body Mass", icon: "figure", records: vm.bodyMass)
        }
        .refreshableTask {
            vm.readBodyMass()
        }
    }
}

#Preview {
    BodyMeasurementsCategory()
        .environment(HealthVM())
}
