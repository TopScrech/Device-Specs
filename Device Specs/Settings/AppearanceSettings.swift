import SwiftUI

struct AppearanceSettings: View {
    @EnvironmentObject private var store: ValueStore
    
    var body: some View {
        Section {
            Picker("Appearance", selection: $store.appearance) {
                ForEach(ColorTheme.allCases) {
                    Text($0.loc)
                        .tag($0)
                }
            }
        }
    }
}

#Preview {
    List {
        AppearanceSettings()
    }
    .environmentObject(ValueStore())
}
