import SwiftUI

#warning("Add capacity and cycle fetcher")
//BatteryCycleCount = How many Times your Battery has been charged
//MaximumFCC = Max. Designed Capacity of your Battery when it was new
//NominalChargeCapacity = Capacity of your Battery now

/// Steps:
//Open Settings
//Privacy & Security
//Analytics & Improvements
//Analytics Data
//Search: "log-aggregated"-YYYY-MM-DD-XXXXXX.ips (Pick the latest)
//Click Top right "Share" > "Save to Files" e.g. "Downloads"

//"I don't have a log-aggregated file on my iOS Device"
//Make sure that the Share iPhone & Watch Analytics option is enabled under Analytics & Enhancements. If it is not, enable the option and wait a few hours or days until you find a file named "log-aggregated". After that, it is recommended to disable Analytics

struct BatterySpecs: View {
    @Environment(BatteryVM.self) private var vm
    
    var body: some View {
        List {
            BatteryLevel()
            BatteryState()
            
            LabeledContent("Low power mode", value: vm.lowPowerMode)
            LabeledContent("Voltage", value: vm.voltage)
            LabeledContent("Capacity", value: vm.capacity)
        }
        .navigationTitle("Battery")
        .environment(vm)
        .refreshableTask {
            vm.fetchBatteryInfo()
        }
#if !os(watchOS)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            vm.fetchBatteryInfo()
        }
#endif
    }
}

#Preview {
    NavigationStack {
        BatterySpecs()
    }
    .environment(BatteryVM())
    .darkSchemePreferred()
}
