import ScrechKit

struct BatterySpecs: View {
    @State private var vm = BatteryVM()
    
    var body: some View {
        List {
            // Model Information Section
            Section("Model Information") {
                SpecItem("Serial Number", param: vm.serialNumber)
                SpecItem("Device Name", param: vm.deviceName)
                SpecItem("Pack Lot Code", param: vm.packLotCode)
                SpecItem("PCB Lot Code", param: vm.pcbLotCode)
                SpecItem("Firmware Version", param: vm.firmwareVersion)
                SpecItem("Hardware Revision", param: vm.hardwareRevision)
                SpecItem("Cell Revision", param: vm.cellRevision)
            }
            
            // Charge Information Section
            Section("Charge Information") {
                SpecItem("Below Warning Level", param: vm.isBelowWarningLevel == true ? "Yes" : "No")
                SpecItem("Fully Charged", param: vm.isFullyCharged == true ? "Yes" : "No")
                SpecItem("Charging", param: vm.isCharging == true ? "Yes" : "No")
                SpecItem("State of Charge (%)", param: vm.stateOfCharge != nil ? "\(vm.stateOfCharge!)%" : "Unknown")
            }
            
            // Health Information Section
            Section("Health Information") {
                SpecItem("Cycle Count", param: vm.cycleCount != nil ? "\(vm.cycleCount!)" : "Unknown")
                SpecItem("Condition", param: vm.condition)
                SpecItem("Maximum Capacity", param: vm.maximumCapacityPercent != nil ? "\(vm.maximumCapacityPercent!)%" : "Unknown")
            }
        }
        .navigationTitle("Battery Info")
    }
}

struct SpecItem: View {
    private let name: String
    private let param: String
    
    init(_ name: String, param: String) {
        self.name = name
        self.param = param
    }
    
    var body: some View {
        HStack {
            Text(name)
            
            Spacer()
            
            Text(param)
        }
    }
}


#Preview {
    BatterySpecs()
}
