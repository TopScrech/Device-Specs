import SwiftUI

struct GPUFamilies: View {
    private var vm = GPUFamiliesVM()
    
    var body: some View {
        List {
            Section {
                ForEach(vm.supportedFamilies) {
                    Text($0.name)
                }
            }
            
            Section("Unsupported") {
                ForEach(vm.unsupportedFamilies) {
                    Text($0.name)
                }
            }
        }
        .navigationTitle("GPU families")
        .scrollIndicators(.never)
    }
}

#Preview {
    NavigationStack {
        GPUFamilies()
    }
}
