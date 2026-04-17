import SwiftUI

struct KnownTimeZones: View {
    private let zones: [String]
    
    init(_ zones: [String]) {
        self.zones = zones
    }
    
    @State private var searchText = ""
    
    private var foundZones: [String] {
        searchText.isEmpty ? zones : zones.filter {
            $0.localizedStandardContains(searchText)
        }
    }
    
    var body: some View {
        List(foundZones, id: \.self) { zone in
#if os(tvOS)
            Button(zone) {}
#else
            Text(zone)
#endif
        }
        .navigationTitle("Known Time Zones")
        .animation(.default, value: foundZones)
        .searchable(text: $searchText)
    }
}

#Preview {
    NavigationStack {
        KnownTimeZones(["Preview"])
    }
    .darkSchemePreferred()
}
