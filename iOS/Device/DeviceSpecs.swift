import ScrechKit
import DeviceKit

fileprivate let identifier: String = {
    var systemInfo = utsname()
    uname(&systemInfo)
    let mirror = Mirror(reflecting: systemInfo.machine)
    
    let identifier = mirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else {
            return identifier
        }
        
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    return identifier
}()

struct DeviceSpecs: View {
    @Environment(DeviceVM.self) private var vm
    
    var body: some View {
        List {
            ListParam("Device", param: vm.deviceIdentifier)
            ListParam("Identifier", param: identifier)
            ListParam("Name", param: vm.deviceName)
            ListParam("Release date", param: vm.releaseDate)
            ListParam("Internal name", param: vm.internalName)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Identifier for vendor")
                
                Text(vm.vandorId)
                    .secondary()
            }
            
            Section {
                ListParam("Thermal state", param: vm.thermalState)
            }
            
            Section("Capabilities") {
                ListParam("Bluetooth", param: vm.bluetoothVersion)
#if !os(tvOS)
                AuthTest()
#endif
                
#if os(iOS)
                ListParam("Wireless Charging", param: Device.current.supportsWirelessCharging ? "Yes" : "No")
                ListParam("5G", param: Device.current.has5gSupport ? "Yes" : "No")
                ListParam("Dynamic Island", param: Device.current.hasDynamicIsland ? "Yes" : "No")
                ListParam("Dock connector", param: Device.current.hasUSBCConnectivity ? "USB-C" : "Lightning")
                ListParam("Force Touch", param: vm.isForceTouchAvailable)
#endif
                ListParam("Ultra Wideband", param: vm.isUltraWidebandAvailable)
            }
            
            Section("Water resistance") {
                ListParam("Rating", param: vm.waterResistance)
#if os(watchOS)
                ListParam("System rating", param: vm.waterResistanceSystemRating)
#endif
                ListParam("Description", param: vm.waterResistanceDescription)
            }
#if os(watchOS)
            DeviceWatchInfo()
#endif
            
#if os(iOS)
            Volume()
#endif
        }
        .navigationTitle("Device")
        .scrollIndicators(.never)
    }
}

#Preview {
    NavigationStack {
        DeviceSpecs()
    }
    .darkSchemePreferred()
    .environment(DeviceVM())
}
