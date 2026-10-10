import SwiftUI

struct DeviceSpecs: View {
#if os(iOS)
    @ObservedObject private var store = ValueStore.shared
#endif

    @Environment(DeviceVM.self) private var vm
    
    var body: some View {
        List {
            LabeledContent("Device", value: DeviceVM.deviceIdentifier)
            LabeledContent("Identifier", value: DeviceVM.hardwareIdentifier)
            LabeledContent("Name", value: DeviceVM.deviceName)
            LabeledContent("Release date", value: DeviceVM.releaseDate)
            LabeledContent("Internal name", value: vm.internalName)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Identifier for vendor")
                
                Text(vm.vendorID)
                    .secondary()
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
            }
            
            Section {
                LabeledContent("Thermal state", value: DeviceVM.thermalState)
            }
            
            Section("Capabilities") {
                LabeledContent("Bluetooth", value: DeviceVM.bluetoothVersion)
#if os(iOS) || os(visionOS)
                AuthTest()
#endif
                
#if os(iOS)
                LabeledContent("Wireless Charging", value: DeviceVM.hasWirelessCharging.yesOrNo())
                LabeledContent("MagSafe", value: DeviceVM.isMagsafeSupported.yesOrNo())
                LabeledContent("5G", value: DeviceVM.supports5G.yesOrNo())
                LabeledContent("Dynamic Island", value: DeviceVM.hasDynamicIsland.yesOrNo())
                LabeledContent("Dock connector", value: DeviceVM.dockConnector)
                LabeledContent("Force Touch", value: vm.isForceTouchAvailable)
#endif
                LabeledContent("Ultra Wideband", value: DeviceVM.isUWBAvailable.yesOrNo())
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
