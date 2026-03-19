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
            LabeledContent("Device", value: vm.deviceIdentifier)
            LabeledContent("Identifier", value: identifier)
            LabeledContent("Name", value: vm.deviceName)
            LabeledContent("Release date", value: vm.releaseDate)
            LabeledContent("Internal name", value: vm.internalName)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Identifier for vendor")
                
                Text(vm.vandorId)
                    .secondary()
            }
            
            Section {
                LabeledContent("Thermal state", value: vm.thermalState)
            }
            
            Section("Capabilities") {
                LabeledContent("Bluetooth", value: vm.bluetoothVersion)
#if !os(tvOS) && !os(watchOS)
                AuthTest()
#endif
                
#if os(iOS)
                LabeledContent("Wireless Charging", value: Device.current.supportsWirelessCharging ? "Yes" : "No")
                LabeledContent("MagSafe", value: Device.current.hasMagsafe ? "Yes" : "No")
                LabeledContent("5G", value: Device.current.has5gSupport ? "Yes" : "No")
                LabeledContent("Dynamic Island", value: Device.current.hasDynamicIsland ? "Yes" : "No")
                LabeledContent("Dock connector", value: Device.current.hasUSBCConnectivity ? "USB-C" : "Lightning")
                LabeledContent("Force Touch", value: vm.isForceTouchAvailable)
#endif
                LabeledContent("Ultra Wideband", value: vm.isUltraWidebandAvailable)
            }
            
            Section("Water resistance") {
                LabeledContent("Rating", value: vm.waterResistance)
#if os(watchOS)
                LabeledContent("System rating", value: vm.waterResistanceSystemRating)
#endif
                LabeledContent("Description", value: vm.waterResistanceDescription)
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
