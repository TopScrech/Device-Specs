import ScrechKit
import DeviceKit
//import CoreTelephony
//import AdSupport

struct DeviceSpecs: View {
    @Environment(DeviceVM.self) private var vm
    //    private var bluetooth = BluetoothManager()
    
    var body: some View {
        List {
#warning("Carrier Info")
            //            Button("test") {
            //                //                func fetchCurrentRadioAccessTechnology() {
            //                let networkInfo = CTTelephonyNetworkInfo()
            //
            //                if let currentRadioTech = networkInfo.serviceCurrentRadioAccessTechnology {
            //                    for (carrier, radioTech) in currentRadioTech {
            //                        print("Carrier: \(carrier), Radio Access Technology: \(radioTech)")
            //                    }
            //                } else {
            //                    print("Unable to fetch cellular capabilities.")
            //                }
            //                //                }
            //            }
            
            ListParam("Device", param: "\(vm.deviceIdentifier)")
            ListParam("Identifier", param: Device.identifier)
            ListParam("Name", param: "\(vm.deviceName)")
            ListParam("Internal name", param: vm.getInternalDeviceName() ?? "-")
            
#if os(watchOS)
            if let vendorId = WKInterfaceDevice.current().identifierForVendor?.uuidString {
                ListParam("Identifier for vendor", param: vendorId)
            }
#else
            if let vendorId = UIDevice.current.identifierForVendor?.uuidString {
                ListParam("Identifier for vendor", param: vendorId)
            }
#endif
            
#warning("idfa")
            //                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            //                ListParam("Advertising Identifier (IDFA)", param: idfa)
            
            Section {
                ListParam("Thermal state", param: vm.thermalState)
            }
            
            Section("Capabilities") {
#if os(iOS)
                ListParam("Wireless Charging", param: Device.current.supportsWirelessCharging ? "Yes" : "No")
                ListParam("5G", param: Device.current.has5gSupport ? "Yes" : "No")
                ListParam("Dynamic Island", param: Device.current.hasDynamicIsland ? "Yes" : "No")
                ListParam("Face ID", param: Device.current.isFaceIDCapable ? "Yes" : "No")
                ListParam("Force Touch", param: vm.isForceTouchAvailable)
#endif
                ListParam("Ultra Wideband", param: vm.isUltraWidebandAvailable)
                //                ListParam("Bluetooth LE", param: bluetooth.isBluetoothLeEnabled)
            }
            
#if os(watchOS)
            DeviceWatchInfo()
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
