import ScrechKit
import DeviceKit

struct BatterySpecs: View {
    private var vm = BatteryVM()
    
    var body: some View {
        List {
            ListParameter("Battery level", parameter: vm.batteryLevel)
            ListParameter("Battery state", parameter: vm.batteryState)
        }
        .navigationTitle("Battery")
    }
}

#Preview {
    NavigationView {
        BatterySpecs()
    }
}
