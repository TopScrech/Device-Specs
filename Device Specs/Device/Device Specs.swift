import ScrechKit
import DeviceKit

struct DeviceSpecs: View {
    @Environment(DeviceVM.self) private var vm
    
    var body: some View {
        List {
            ListParam("Device", param: vm.deviceIdentifier)
            ListParam("Identifier", param: Device.identifier)
            ListParam("Name", param: vm.deviceName)
            ListParam("Release date", param: vm.releaseDate)
            ListParam("Internal name", param: vm.internalName)
            ListParam("Identifier for vendor", param: vm.vandorId)
            
//#if !os(watchOS) && !os(visionOS)
//            AdvertisingIdentifier()
//#endif
            
            Section {
                ListParam("Thermal state", param: vm.thermalState)
            }
            
            Section("Capabilities") {
#if !os(tvOS)
                HStack {
                    Text("Biometric authentication")
                    
                    Spacer()
                    
                    
                    Image(systemName: vm.bioIcon)
                        .title3()
                        .foregroundStyle(.secondary)
                    
                    Text(vm.bioType)
                        .foregroundStyle(.secondary)
                }
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
            
#if os(watchOS)
            DeviceWatchInfo()
#else
            Volume()
#endif
        }
        .navigationTitle("Device")
        .scrollIndicators(.never)
    }
}

#Preview {
    DeviceSpecs()
        .environment(DeviceVM())
}
