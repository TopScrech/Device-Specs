import SwiftUI

struct WarningSection: View {
    @Environment(BatteryVM.self) private var battery
    
    private let thermalState = ProcessInfo.processInfo.thermalState
    
    var body: some View {
        Section {
            if thermalState == .serious {
                WarningCard("Serious thermal state", icon: "flame", color: .yellow)
            } else if thermalState == .critical {
                WarningCard("Critical thermal state", icon: "flame.fill", color: .red)
            }
            
            if let batteryLevel = battery.batteryLevelNumber {
                if 11...20 ~= batteryLevel {
                    WarningCard("Low battery", icon: "battery.25percent", color: .yellow)
                }
                
                if 0...10 ~= batteryLevel {
                    WarningCard("Very low battery", icon: "battery.0percent", color: .red)
                }
            }
            
            if battery.lowPowerMode {
                WarningCard("Low power mode", icon: "leaf.fill", color: .green)
                    .animation(.default, value: battery.lowPowerMode)
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
    .environment(BatteryVM())
}
