import ScrechKit
import DeviceKit

struct DeviceView: View {
    private var vm = DeviceVM()
    //    private var bluetooth = BluetoothManager()
    //    let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString
    
    var body: some View {
        List {
            Section("Device") {
                ListParameter("Device", parameter: "\(Device.current)")
                ListParameter("Identifier", parameter: "\(Device.identifier)")
            }
            
            Section("System") {
                ListParameter("Operating system", parameter: vm.operatingSystem)
                ListParameter("Build number", parameter: vm.buildNumber)
            }
            
            Section {
                ListParameter("System language", parameter: Locale.current.identifier)
                ListParameter("System region", parameter: Locale.current.region?.identifier ?? "-")
                ListParameter("System uptime", parameter: vm.fetchSystemUptime())
                ListParameter("Thermal state", parameter: vm.thermalState)
            }
            
            Section("Capabilities") {
#if !os(visionOS)
                ListParameter("Wireless Charging", parameter: Device.current.supportsWirelessCharging ? "Yes" : "No")
                ListParameter("5G", parameter: Device.current.has5gSupport ? "Yes" : "No")
                ListParameter("Dynamic Island", parameter: Device.current.hasDynamicIsland ? "Yes" : "No")
                ListParameter("Face ID", parameter: Device.current.isFaceIDCapable ? "Yes" : "No")
#endif
                ListParameter("Ultra Wideband", parameter: vm.isUltraWidebandAvailable)
                ListParameter("Force Touch", parameter: vm.isForceTouchAvailable)
                //                ListParameter("Bluetooth LE", parameter: bluetooth.isBluetoothLeEnabled)
            }
        }
        .navigationTitle("Device")
    }
}

#Preview {
    DeviceView()
}
