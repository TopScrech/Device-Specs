import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: ValueStore
    
    var body: some View {
        List {
#if canImport(Appearance)
            AppearanceSettings()
#endif
            
#if DEBUG
            Section("Debug") {
                Toggle("Status bar", isOn: $store.showStatusBar)
            }
#endif
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environmentObject(ValueStore())
    .darkSchemePreferred()
}
