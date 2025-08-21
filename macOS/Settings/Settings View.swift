import SwiftUI
import LaunchAtLogin

struct SettingsView: View {
    var body: some View {
        LaunchAtLogin.Toggle()
            .padding()
    }
}

#Preview {
    SettingsView()
}
