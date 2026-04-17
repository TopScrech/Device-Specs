import SwiftUI

struct CurrentProcessEnvironment: View {
    @Environment(ProcessorVM.self) private var vm
    
    private var sortedKeys: [String] {
        vm.environment.keys.sorted()
    }
    
    var body: some View {
        List(sortedKeys, id: \.self) { key in
            Section(key) {
                Text(vm.environment[key] ?? "")
            }
        }
        .navigationTitle("Environment variables")
        .scrollIndicators(.never)
    }
}

#Preview {
    NavigationStack {
        CurrentProcessEnvironment()
    }
    .environment(ProcessorVM())
    .darkSchemePreferred()
}
