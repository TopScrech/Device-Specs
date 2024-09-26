import ScrechKit

struct BatterySpecs: View {
    @Environment(BatteryVM.self) private var vm
    
    var body: some View {
        List {
            BatteryLevel()
            
            BatteryState()
            
            ListParam("Low power mode", param: vm.lowPowerMode)
            
            ListParam("Voltage", param: vm.voltage)
            
            ListParam("Capacity", param: vm.capacity)
            
            ListParam("Capacity in Wh", param: vm.capacityWh)
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
    NavigationView {
        BatterySpecs()
    }
    .environment(BatteryVM())
}
