import SwiftUI
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
            LabeledContent("Device", value: DeviceVM.deviceIdentifier)
            LabeledContent("Identifier", value: identifier)
            LabeledContent("Name", value: DeviceVM.deviceName)
            LabeledContent("Release date", value: DeviceVM.releaseDate)
            LabeledContent("Internal name", value: vm.internalName)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Identifier for vendor")
                
                Text(vm.vendorId)
                    .secondary()
            }
            
            Section {
                LabeledContent("Thermal state", value: DeviceVM.thermalState)
            }
            
            Section("Capabilities") {
                LabeledContent("Bluetooth", value: DeviceVM.bluetoothVersion)
#if !os(tvOS) && !os(watchOS)
                AuthTest()
#endif
                
#if os(iOS)
                LabeledContent("Wireless Charging", value: Device.current.supportsWirelessCharging ? "Yes" : "No")
                LabeledContent("MagSafe", value: DeviceVM.isMagsafeSupported)
                LabeledContent("5G", value: DeviceVM.supports5G)
                LabeledContent("Dynamic Island", value: DeviceVM.hasDynamicIsland)
                LabeledContent("Dock connector", value: DeviceVM.dockConnector)
                LabeledContent("Force Touch", value: vm.isForceTouchAvailable)
#endif
                LabeledContent("Ultra Wideband", value: DeviceVM.isUWBAvailable)
            }
            
            Section("Water resistance") {
                LabeledContent("Rating", value: DeviceVM.waterResistance)
#if os(watchOS)
                LabeledContent("System rating", value: vm.waterResistanceSystemRating)
#endif
                LabeledContent("Description", value: DeviceVM.waterResistanceDescription)
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
