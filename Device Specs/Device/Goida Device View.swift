import ScrechKit

struct GoidaDeviceView: View {
    private var vm = DeviceVM()
    //    private var bluetooth = BluetoothManager()
    //    let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString
    
    var body: some View {
        List {
            Section("Device") {
                ListParameter("Device", parameter: vm.deviceName)
                ListParameter("Model", parameter: vm.deviceIdentifier ?? "-")
                ListParameter("Architecture", parameter: vm.architecture)
            }
            
            Section("System") {
                ListParameter("Operating system", parameter: vm.operatingSystem)
                ListParameter("Build number", parameter: vm.buildNumber)
            }
            
            Section {
                ListParameter("System language", parameter: Locale.current.identifier)
                ListParameter("System region", parameter: Locale.current.region?.identifier ?? "-")
                ListParameter("System uptime", parameter: vm.fetchSystemUptime())
                ListParameter("System uptime", parameter: vm.thermalState)
            }
            
            Section("Capabilities") {
                ListParameter("NFC", parameter: vm.isNfcAvailable)
                ListParameter("Ultra Wideband", parameter: vm.isUltraWidebandAvailable)
                ListParameter("Force Touch", parameter: vm.isForceTouchAvailable)
                //                ListParameter("Bluetooth LE", parameter: bluetooth.isBluetoothLeEnabled)
            }
        }
        .navigationTitle("Device")
    }
}

#Preview {
    GoidaDeviceView()
}
