import SwiftUI

struct BatterySpecs: View {
    @Environment(BatteryVM.self) private var vm
    
    var body: some View {
        List {
            BatteryLevel()
            BatteryState()
            
            LabeledContent("Low power mode", value: vm.lowPowerMode.yesOrNo())
            LabeledContent("Voltage", value: vm.voltage)
            LabeledContent("Capacity", value: vm.capacity)
        }
        .navigationTitle("Battery")
        .environment(vm)
        .refreshableTask {
            vm.fetchBatteryInfo()
        }
#if !os(watchOS)
        .task {
            for await _ in NotificationCenter.default.notifications(named: UIApplication.didBecomeActiveNotification) {
                vm.fetchBatteryInfo()
            }
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
