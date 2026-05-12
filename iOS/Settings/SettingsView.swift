import ScrechKit

struct SettingsView: View {
    var body: some View {
        List {
#if canImport(Appearance)
            AppearanceSettings()
#endif
            Button("Change language", systemImage: "globe") {
                openSettings()
            }
            .foregroundStyle(.foreground)
        }
        .navigationTitle("Settings")
        .toolbar {
            NavigationLink {
                DebugSettings()
            } label: {
                Label(String("Debug settings"), systemImage: "hammer")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environmentObject(ValueStore())
    .darkSchemePreferred()
}
