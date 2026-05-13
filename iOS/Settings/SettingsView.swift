import ScrechKit

struct SettingsView: View {
    let githubURL = URL(string: "https://github.com/TopScrech/Device-Specs")!
    
    var body: some View {
        List {
            Section {
#if canImport(Appearance)
                AppearanceSettings()
#endif
                Button("Change language", systemImage: "globe") {
                    openSettings()
                }
                .foregroundStyle(.foreground)
            }
            
            Section {
                Link(destination: githubURL) {
                    HStack {
                        Image(.gitHub)
                            .resizable()
                            .frame(20)
                            .padding(-1)
                            .background(.white, in: .circle)
                        
                        Text("GitHub")
                    }
                }
                .tint(.primary)
            } footer: {
                Text("Issue reports, feature requests & contributions are always welcome!")
            }
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
