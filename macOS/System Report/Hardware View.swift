import SwiftUI

struct HardwareView: View {
    @State private var vm = HardwareVM()
    
    var body: some View {
        List {
            Section("Hardware Overview") {
                SpecItem("Model Name", param: vm.modelName)
                SpecItem("Model Identifier", param: vm.modelIdentifier)
                SpecItem("Model Number", param: vm.modelNumber)
                SpecItem("Chip", param: vm.chip)
                SpecItem("Total Number of Cores", param: vm.totalNumberOfCores)
                SpecItem("Memory", param: vm.memory)
                SpecItem("System Firmware Version", param: vm.systemFirmwareVersion)
                SpecItem("OS Loader Version", param: vm.osLoaderVersion)
                SpecItem("Serial Number (system)", param: vm.serialNumber)
                SpecItem("Hardware UUID", param: vm.hardwareUUID)
                SpecItem("Provisioning UDID", param: vm.provisioningUDID)
                SpecItem("Activation Lock Status", param: vm.activationLockStatus)
            }
        }
        .navigationTitle("Hardware Info")
        .onAppear {
            vm.fetchHardwareInfo()
        }
    }
}

#Preview {
    HardwareView()
}
