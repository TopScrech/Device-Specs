import ScrechKit

struct BatterySpecs: View {
    @Environment(BatteryVM.self) private var vm
    
    var body: some View {
        List {
            BatteryLevel()
            
            BatteryState()
            
            ListParam("Low power mode", param: vm.lowPowerMode)
        }
        .navigationTitle("Battery")
        .environment(vm)
        .refreshableTask {
            vm.fetchBatteryInfo()
        }
    }
}

#Preview {
    NavigationView {
        BatterySpecs()
    }
    .environment(BatteryVM())
}
