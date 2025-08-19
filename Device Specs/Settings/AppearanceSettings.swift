import SwiftUI

struct AppearanceSettings: View {
    @EnvironmentObject private var store: ValueStore
    
    var body: some View {
        Section {
            Picker("Appearance", selection: $store.appearance) {
                ForEach(ColorTheme.allCases) { theme in
                    Text(theme.loc)
                        .tag(theme)
                }
            }
        }
    }
}

#Preview {
    List {
        AppearanceSettings()
    }
    .darkSchemePreferred()
    .environmentObject(ValueStore())
}
