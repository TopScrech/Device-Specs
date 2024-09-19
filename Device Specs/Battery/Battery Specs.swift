import ScrechKit

struct BatterySpecs: View {
    @Environment(BatteryVM.self) private var vm
    
    var body: some View {
        List {
            BatteryLevel()
            
            BatteryState()
            
            ListParameter("Low power mode", parameter: vm.lowPowerMode)
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
}
