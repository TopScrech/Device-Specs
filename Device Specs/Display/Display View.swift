import ScrechKit
import DeviceKit

struct DisplaySpecs: View {
    private var display = DisplayVM()
    
    var body: some View {
        List {
#warning("fix")
            if let ppi = Device.current.ppi {
                ListParameter("PPI", parameter: "\(ppi)")
            }
            
            ListParameter("Screen resolution", parameter: display.fetchScreenResolution())
            ListParameter("Refresh rate", parameter: display.refreshRate)
            ListParameter("Brightness", parameter: "\(Device.current.screenBrightness)%")
        }
        .navigationTitle("Display")
    }
}

#Preview {
    DisplaySpecs()
}
