import ScrechKit

struct BatterySpecs: View {
    @State private var vm = BatteryVM()
    
    var body: some View {
        Text(vm.cycleCount)
    }
}

#Preview {
    BatterySpecs()
}
