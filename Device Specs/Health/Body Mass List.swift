import SwiftUI

struct BodyMassList: View {
    @Environment(HealthVM.self) private var vm
    
    var body: some View {
        List {
            ForEach(vm.bodyMass) { record in
                Text(record.value)
            }
        }
    }
}

#Preview {
    BodyMassList()
        .environment(HealthVM())
}
