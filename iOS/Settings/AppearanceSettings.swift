import SwiftUI
import Appearance

struct AppearanceSettings: View {
    @EnvironmentObject private var store: ValueStore
    
    var body: some View {
        Section {
            AppearancePicker($store.appearance)
                .foregroundStyle(.primary)
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
