import ScrechKit
import DeviceKit

struct DisplaySpecs: View {
    private var display = DisplayVM()
    
    @State private var brightness = 0.0
    
    init() {
        self.brightness = Double(Device.current.screenBrightness) * 100
    }
    
    var body: some View {
        List {
            if let ppi = Device.current.ppi?.description {
                ListParameter("PPI", parameter: ppi)
            }
            
            ListParameter("Screen resolution", parameter: display.fetchScreenResolution())
            ListParameter("Refresh rate", parameter: display.refreshRate)
            
            let isRounded = Device.current.hasRoundedDisplayCorners ? "Yes" : "No"
            ListParameter("Rounded corners", parameter: isRounded)
            
            
            Section {
                ListParameter("Brightness", parameter: "\(Int(brightness))%")
                
                Slider(value: $brightness, in: 0...100, step: 1) {
                    Text("Brightness")
                }
            }
        }
        .navigationTitle("Display")
        .onChange(of: brightness) { _, newValue in
            setDeviceBrightness(to: CGFloat(newValue))
        }
    }
    
    private func setDeviceBrightness(to level: CGFloat) {
        UIScreen.main.brightness = brightness
    }
}

#Preview {
    DisplaySpecs()
}
