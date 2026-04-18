import SwiftUI

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @State private var connectivity = ConnectivityVM()
    
    var body: some View {
        List {
            LabeledContent("Public IP address", value: network.publicIP)
            LabeledContent("Network interface", value: network.networkInterface)
            LabeledContent("Router", value: network.destinationIpAddress)
            LabeledContent("Subnet mask", value: network.subnetMask)
            
            Section {
                LabeledContent("Network type", value: connectivity.type)
            }
        }
        .navigationTitle("Network")
        .refreshable {
            await network.getIPAddresses()
        }
    }
}

#Preview {
    NavigationStack {
        NetworkSpecs()
    }
    .darkSchemePreferred()
}
