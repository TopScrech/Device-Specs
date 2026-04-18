import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: ValueStore
    
    var body: some View {
        List {
#if canImport(Appearance)
            AppearanceSettings()
#endif
            Section("Debug") {
                Toggle("Status bar", isOn: $store.showStatusBar)
                Toggle(String("Debug mode"), isOn: $store.debugMode)
            }
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
