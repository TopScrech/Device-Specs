import SwiftUI

struct WarningSection: View {
    private let thermalState = ProcessInfo.processInfo.thermalState
    
    var body: some View {
        Section {
            if thermalState == .serious {
                WarningCard("Serious thermal state", icon: "flame", color: .yellow)
            } else if thermalState == .critical {
                WarningCard("Critical thermal state", icon: "flame.fill", color: .red)
            }
        }
    }
}

#Preview {
    List {
        WarningCard("Serious thermal state", icon: "flame", color: .yellow)
        WarningCard("Critical thermal state", icon: "flame.fill", color: .red)
        WarningCard("Low battery", icon: "battery.25percent", color: .yellow)
        WarningCard("Very low battery", icon: "battery.0percent", color: .red)
        WarningCard("Low power mode", icon: "leaf.fill", color: .green)
    }
    .darkSchemePreferred()
}
