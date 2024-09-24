import SwiftUI

struct KnownTimeZones: View {
    private let zones: [String]
    
    init(_ zones: [String]) {
        self.zones = zones
    }
    
    @State private var searchText = ""
    
    private var foundZones: [String] {
        searchText.isEmpty ? zones : zones.filter {
            $0.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        List(foundZones, id: \.self) { zone in
            Text(zone)
        }
        .animation(.default, value: foundZones)
        .searchable(text: $searchText)
        .navigationTitle("Known Time Zones")
    }
}

#Preview {
    KnownTimeZones(["Preview"])
}
