import ScrechKit

struct BatterySpecs: View {
    @State private var vm = BatteryVM()
    
    var body: some View {
        List {
            HStack {
                Text("Battery level")
                
                Spacer()
                
                VStack {
                    Text(vm.batteryLevel)
                        .foregroundStyle(.secondary)
                    
                    Image(systemName: vm.icon)
                        .title()
                        .foregroundColor(vm.color)
                        .symbolRenderingMode(vm.batteryState == "Full" ? .multicolor : .hierarchical)
                }
            }
            
            HStack {
                Text("Battery state")
                
                Spacer()
                
                Text(vm.batteryState)
                    .foregroundStyle(.secondary)
                
                if vm.batteryState == "Charging" {
                    Image(systemName: "bolt.fill")
                        .footnote()
                }
            }
            
            ListParameter("Low power mode", parameter: vm.lowPowerMode)
        }
        .navigationTitle("Battery")
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
