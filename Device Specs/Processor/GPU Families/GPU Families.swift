import SwiftUI

struct GPUFamilies: View {
    private var vm = GPUFamiliesVM()
    
    var body: some View {
        List {
            Section {
                ForEach(vm.supportedFamilies) { family in
                    Text(family.name)
                }
            }
            
            Section("Unsupported") {
                ForEach(vm.unsupportedFamilies) { family in
                    Text(family.name)
                }
            }
        }
        .navigationTitle("GPU families")
        .scrollIndicators(.never)
    }
}

#Preview {
    GPUFamilies()
}
