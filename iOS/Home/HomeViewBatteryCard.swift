import SwiftUI

struct HomeViewBatteryCard: View {
#if os(iOS)
    @ObservedObject private var store = ValueStore.shared
#endif

    @Environment(BatteryVM.self) private var battery
    
    private var level: Int? {
        guard let level = battery.batteryLevelNumber, level >= 0 else {
            return nil
        }
        
        return level
    }
    
    private var stateColor: Color {
        if battery.batteryState == "Charging" {
            .green
        } else if battery.lowPowerMode {
            .yellow
        } else {
            .secondary
        }
    }
    
    var body: some View {
        HomeViewCard(
            "Battery",
            icon: battery.batteryState == "Charging" ? "battery.100percent.bolt" : battery.icon,
            value: level == nil ? "N/a" : battery.batteryLevel,
            detail: Text(LocalizedStringKey(battery.batteryState)).foregroundStyle(stateColor)
        ) {
            BatterySpecs()
                .environment(battery)
        }
    }
}
