import SwiftUI

struct DebugSettings: View {
    @EnvironmentObject private var store: ValueStore
    
    let versionAndBuild = "v\(Bundle.version ?? "-") (B\(Bundle.build ?? "-"))"
    
    var body: some View {
        List {
            Section {
                LabeledContent(String("Version"), value: versionAndBuild)
            }
            
            Section {
                Toggle(String("Status bar"), isOn: $store.showStatusBar)
            }
        }
        .navigationTitle(String("Debug settings"))
    }
}

#Preview {
    DebugSettings()
        .environmentObject(ValueStore())
}
