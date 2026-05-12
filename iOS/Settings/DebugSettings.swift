import SwiftUI

struct DebugSettings: View {
    @EnvironmentObject private var store: ValueStore
    
    var body: some View {
        List {
            Toggle(String("Status bar"), isOn: $store.showStatusBar)
        }
        .navigationTitle(String("Debug settings"))
    }
}

#Preview {
    DebugSettings()
        .environmentObject(ValueStore())
}
