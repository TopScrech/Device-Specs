import SwiftUI

#if canImport(Appearance)
import Appearance
#endif

struct AppearanceSettings: View {
    @EnvironmentObject private var store: ValueStore
    
    var body: some View {
        Section {
            AppearancePicker($store.appearance)
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
