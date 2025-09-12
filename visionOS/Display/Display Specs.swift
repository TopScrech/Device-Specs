import ScrechKit
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
                ListParam("PPI", param: ppi)
            }
            
            Section {
                ListParam("Brightness", param: "\(Int(brightness))%")
            }
        }
        .navigationTitle("Display")
    }
}

#Preview {
    NavigationStack {
        DisplaySpecs()
    }
}
