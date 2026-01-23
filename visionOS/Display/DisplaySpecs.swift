import SwiftUI
import DeviceKit

struct DisplaySpecs: View {
    @State private var brightness = 0.0
    
    init() {
        _brightness = State(initialValue: Double(Device.current.screenBrightness))
    }
    
#warning("Check if works")
    var body: some View {
        List {
            if let ppi = Device.current.ppi?.description {
                LabeledContent("PPI", value: ppi)
            }
            
            Section {
                LabeledContent("Brightness", value: "\(Int(brightness))%")
            }
        }
        .navigationTitle("Display")
    }
}

#Preview {
    NavigationStack {
        DisplaySpecs()
    }
    .darkSchemePreferred()
}
