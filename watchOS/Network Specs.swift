import ScrechKit

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @State private var connectivity = ConnectivityVM()
    
    var body: some View {
        List {
            ListParam("Public IP address", param: network.publicIp)
            
            ListParam("Network interface", param: network.networkinterface)
            
#warning("Router differs from settings")
            ListParam("Router", param: network.router)
            
            ListParam("Subnet mask", param: network.subnetMask)
            
            Section {
                ListParam("Network type", param: connectivity.type)
            }
        }
        .navigationTitle("Network")
        .refreshableTask {
            network.getIPAddresses()
        }
    }
}

#Preview {
    NetworkSpecs()
}
