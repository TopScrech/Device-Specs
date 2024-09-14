import ScrechKit
import DeviceKit

struct DisplaySpecs: View {
    private var display = DisplayVM()
    
    @State private var brightness = 0.0
    
    init() {
        _brightness = State(initialValue: Double(Device.current.screenBrightness))
    }
    
    var body: some View {
        List {
            ListParameter("Screen resolution", parameter: display.resolution)
            
            ListParameter("Refresh rate", parameter: display.refreshRate)
            
            Section {
                ListParameter("Brightness", parameter: "\(Int(brightness))%")
            }
        }
        .navigationTitle("Display")
        .refreshableTask {
            display.fetchScreenResolution()
        }
    }
}

#Preview {
    DisplaySpecs()
}
