import SwiftUI

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @Environment(ConnectivityVM.self) private var connectivity
    
    var body: some View {
        List {
            LabeledContent("Public IP address", value: network.publicIP)
            
            LabeledContent("Network interface", value: network.networkInterface)
            
            LabeledContent("Destination IP address", value: network.destinationIpAddress)
            
            if let router = RouterVM().fetch() {
                LabeledContent("Router", value: router)
            }
            
            LabeledContent("Subnet mask", value: network.subnetMask)
            
            Section {
                LabeledContent("Network type", value: connectivity.type)
                
                if let ssid = connectivity.ssid {
                    LabeledContent("SSID", value: ssid)
                }
                
                if let bssid = connectivity.bssid {
                    LabeledContent("BSSID", value: bssid)
                }
                
                if let signalStrength = connectivity.signalStrength {
                    LabeledContent("Signal strength", value: String(format: "%.0f%%", signalStrength * 100))
                }
                
                if let isSecure = connectivity.isSecure {
                    LabeledContent("Secure network", value: isSecure ? "Yes" : "No")
                }
                
                if let didAutoJoin = connectivity.didAutoJoin {
                    LabeledContent("Auto-joined", value: didAutoJoin ? "Yes" : "No")
                }
                
                if let didJustJoin = connectivity.didJustJoin {
                    LabeledContent("Just joined", value: didJustJoin ? "Yes" : "No")
                }
                
                if let isChosenHelper = connectivity.isChosenHelper {
                    LabeledContent("Hotspot Helper", value: isChosenHelper ? "Yes" : "No")
                }
                
                if let securityType = connectivity.securityType {
                    LabeledContent("Security type", value: securityType)
                }
            }
        }
        .navigationTitle("Network")
        .refreshableTask {
            async let getIPAddresses: () = network.getIPAddresses()
            async let getWiFiInfo: () = connectivity.getWiFiInfo()
            
            _ = await (getIPAddresses, getWiFiInfo)
        }
    }
}

#Preview {
    NavigationStack {
        NetworkSpecs()
    }
    .environment(ConnectivityVM())
    .darkSchemePreferred()
}
