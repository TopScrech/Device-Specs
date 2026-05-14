import SwiftUI
import Appearance

struct AppearanceSettings: View {
    @EnvironmentObject private var store: ValueStore
    
    var body: some View {
        AppearancePicker($store.appearance)
            .foregroundStyle(.primary)
    }
}

#Preview {
    List {
        AppearanceSettings()
    }
    .darkSchemePreferred()
    .environmentObject(ValueStore())
}
