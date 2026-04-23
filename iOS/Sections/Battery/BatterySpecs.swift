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
