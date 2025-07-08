import ScrechKit

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @State private var connectivity = ConnectivityVM()
    
    var body: some View {
        List {
            ListParam("Public IP address", param: network.publicIp)
            
            ListParam("Network interface", param: network.networkInterface)
            
            ListParam("Router", param: network.destinationIpAddress)
            
            if let router = RouterVM().fetch() {
                ListParam("Router", param: router)
            }
            
            ListParam("Subnet mask", param: network.subnetMask)
            
            Section {
                ListParam("Network type", param: connectivity.type)
            }
        }
        .navigationTitle("Network")
        .refreshableTask {
            await network.getIPAddresses()
        }
    }
}

#Preview {
    NetworkSpecs()
}
