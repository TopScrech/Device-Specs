import SwiftUI

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @State private var connectivity = ConnectivityVM()
    
    var body: some View {
        List {
            LabeledContent("Public IP address", value: network.publicIp)
            
            LabeledContent("Network interface", value: network.networkInterface)
            
            LabeledContent("Router", value: network.destinationIpAddress)
            
            if let router = RouterVM().fetch() {
                LabeledContent("Router", value: router)
            }
            
            LabeledContent("Subnet mask", value: network.subnetMask)
            
            Section {
                LabeledContent("Network type", value: connectivity.type)
            }
        }
        .navigationTitle("Network")
        .refreshableTask {
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
