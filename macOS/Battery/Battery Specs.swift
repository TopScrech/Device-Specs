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
                
                SpecItem("State of Charge (%)", param: vm.stateOfCharge != nil ? "\(vm.stateOfCharge!)%" : "Unknown")
            }
            
            // Health Information Section
            Section("Health Information") {
                Param("Cycle Count", param: vm.cycleCount)
                SpecItem("Condition", param: vm.condition)
                SpecItem("Maximum Capacity", param: vm.maximumCapacityPercent != nil ? "\(vm.maximumCapacityPercent!)%" : "Unknown")
            }
        }
        .navigationTitle("Battery Info")
    }
}

struct Param: View {
    private let name: LocalizedStringResource
    private let value: String
    
    init(_ name: LocalizedStringResource, param: Bool?) {
        self.name = name
        
        if let param {
            self.value = param ? "Yes" : "No"
        } else {
            self.value = "Unknown"
        }
    }
    
    init(_ name: LocalizedStringResource, param: String?) {
        self.name = name
        
        if let param {
            self.value = param
        } else {
            self.value = "Unknown"
        }
    }
    
    init(_ name: LocalizedStringResource, param: Int?) {
        self.name = name
        
        if let param {
            self.value = param.description
        } else {
            self.value = "Unknown"
        }
    }
    
    var body: some View {
        HStack {
            Text(name)
            
            Spacer()
            
            Text(value)
        }
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
