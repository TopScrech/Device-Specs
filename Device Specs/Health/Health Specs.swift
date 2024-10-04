import SwiftUI

struct HealthSpecs: View {
    @State private var vm = HealthVM()
    
    var body: some View {
        List {
            HealthAvailability()
            
            NavigationLink {
                BodyMassList()
                    .environment(vm)
            } label: {
                Text("Body mass")
            }
        }
    }
}

#Preview {
    HealthSpecs()
}
