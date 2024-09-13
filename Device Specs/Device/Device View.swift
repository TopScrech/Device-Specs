import ScrechKit
import DeviceKit
//import CoreTelephony
//import AdSupport

struct DeviceView: View {
    private var vm = DeviceVM()
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
            
            Section("Device") {
                ListParameter("Device", parameter: "\(Device.current)")
                ListParameter("Identifier", parameter: Device.identifier)
                
                if let vendorId = UIDevice.current.identifierForVendor?.uuidString {
                    ListParameter("Vendor identifier", parameter: vendorId)
                }
                
#warning("idfa")
                //                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                //                ListParameter("Advertising Identifier (IDFA)", parameter: idfa)
            }
            
            Section("System") {
                ListParameter("Operating system", parameter: vm.operatingSystem)
                ListParameter("Build number", parameter: vm.buildNumber)
            }
            
            Section {
                let locale = Locale.current
                
                ListParameter("System language", parameter: locale.identifier)
                ListParameter("System region", parameter: locale.region?.identifier ?? "-")
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
        .navigationTitle("Device and system")
    }
}

#Preview {
    DeviceView()
}
