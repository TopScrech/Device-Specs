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
                    LabeledContent("Signal strength", value: signalStrength.formatted(.percent.precision(.fractionLength(0))))
                }
                
                if let isSecure = connectivity.isSecure {
                    LabeledContent("Secure network", value: isSecure.yesOrNo())
                }
                
                if let didAutoJoin = connectivity.didAutoJoin {
                    LabeledContent("Auto-joined", value: didAutoJoin.yesOrNo())
                }
                
                if let didJustJoin = connectivity.didJustJoin {
                    LabeledContent("Just joined", value: didJustJoin.yesOrNo())
                }
                
                if let isChosenHelper = connectivity.isChosenHelper {
                    LabeledContent("Hotspot Helper", value: isChosenHelper.yesOrNo())
                }
                
                if let securityType = connectivity.securityType {
                    LabeledContent("Security type", value: securityType)
                }
            }
            
            Section {
                if let pathStatus = connectivity.pathStatus {
                    LabeledContent("Status", value: pathStatus)
                    
                    if let pathUnsatisfiedReason = connectivity.pathUnsatisfiedReason {
                        LabeledContent("Unsatisfied reason", value: pathUnsatisfiedReason)
                    }
                    
                    LabeledContent("IPv4 support", value: connectivity.supportsIPv4.yesOrNo())
                    LabeledContent("IPv6 support", value: connectivity.supportsIPv6.yesOrNo())
                    LabeledContent("DNS support", value: connectivity.supportsDNS.yesOrNo())
                    LabeledContent("Low Data Mode", value: connectivity.lowDataMode.yesOrNo())
                    
                    if let linkQuality = connectivity.linkQuality {
                        LabeledContent("Link quality", value: linkQuality)
                    }
                } else {
                    Text("Waiting for network path")
                        .secondary()
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
