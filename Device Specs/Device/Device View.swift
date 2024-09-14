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
                
#if os(watchOS)
                if let vendorId = WKInterfaceDevice.current().identifierForVendor?.uuidString {
                    ListParameter("Identifier for vendor", parameter: vendorId)
                }
#else
                if let vendorId = UIDevice.current.identifierForVendor?.uuidString {
                    ListParameter("Identifier for vendor", parameter: vendorId)
                }
#endif
                
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
#if os(iOS)
                ListParameter("Wireless Charging", parameter: Device.current.supportsWirelessCharging ? "Yes" : "No")
                ListParameter("5G", parameter: Device.current.has5gSupport ? "Yes" : "No")
                ListParameter("Dynamic Island", parameter: Device.current.hasDynamicIsland ? "Yes" : "No")
                ListParameter("Face ID", parameter: Device.current.isFaceIDCapable ? "Yes" : "No")
                ListParameter("Force Touch", parameter: vm.isForceTouchAvailable)
#endif
                ListParameter("Ultra Wideband", parameter: vm.isUltraWidebandAvailable)
                //                ListParameter("Bluetooth LE", parameter: bluetooth.isBluetoothLeEnabled)
            }
            
#if os(watchOS)
            DeviceWatchInfo()
#endif
        }
        .navigationTitle("Device and system")
    }
}

#Preview {
    DeviceView()
}
