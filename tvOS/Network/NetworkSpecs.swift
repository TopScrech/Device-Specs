import SwiftUI

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @Environment(ConnectivityVM.self) private var connectivity
    
    var body: some View {
        List {
            LabeledContent("Public IP address", value: network.publicIp)
            
            LabeledContent("Network type", value: connectivity.type)
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
