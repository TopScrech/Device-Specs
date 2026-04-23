import ScrechKit

struct SettingsView: View {
    @EnvironmentObject private var store: ValueStore
    
    var body: some View {
        List {
#if canImport(Appearance)
            AppearanceSettings()
#endif
            Button("Change language", systemImage: "globe") {
                openSettings()
            }
            .foregroundStyle(.foreground)
            
            Section("Debug") {
                Toggle("Status bar", isOn: $store.showStatusBar)
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
