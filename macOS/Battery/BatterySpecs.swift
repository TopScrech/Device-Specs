import ScrechKit

struct BatterySpecs: View {
    @State private var vm = BatteryVM()
    
    var body: some View {
        List {
            // Model Information Section
            Section("Model Information") {
                Param("Serial Number", param: vm.serialNumber)
                Param("Device Name", param: vm.deviceName)
                Param("Pack Lot Code", param: vm.packLotCode)
                Param("PCB Lot Code", param: vm.pcbLotCode)
                
                Param("Firmware Version", param: vm.firmwareVersion)
                Param("Hardware Revision", param: vm.hardwareRevision)
                Param("Cell Revision", param: vm.cellRevision)
            }
            
            // Charge Information Section
            Section("Charge Information") {
                Param("Below Warning Level", param: vm.isBelowWarningLevel)
                Param("Fully Charged", param: vm.isFullyCharged)
                Param("Charging", param: vm.isCharging)
                Param("State of Charge (%)", param: vm.stateOfCharge)
            }
            
            // Health Information Section
            Section("Health Information") {
                Param("Cycle Count", param: vm.cycleCount)
                Param("Condition", param: vm.condition)
                Param("Maximum Capacity", param: vm.maximumCapacityPercent)
            }
        }
        .navigationTitle("Battery Info")
    }
}

#Preview {
    NavigationStack {
        BatterySpecs()
    }
    .darkSchemePreferred()
}
