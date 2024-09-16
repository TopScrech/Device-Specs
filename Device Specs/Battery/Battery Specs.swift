import ScrechKit

struct BatterySpecs: View {
    @State private var vm = BatteryVM()
    
    var body: some View {
        List {
            ListParameter("Battery level", parameter: vm.batteryLevel)
            
            ListParameter("Battery state", parameter: vm.batteryState)
            
            ListParameter("Low power mode", parameter: vm.lowPowerMode)
        }
        .navigationTitle("Battery")
    }
}

#Preview {
    NavigationView {
        BatterySpecs()
    }
}
