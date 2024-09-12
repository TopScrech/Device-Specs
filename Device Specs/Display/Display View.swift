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
            
            ListParameter("Aspect ratio", parameter: display.aspectRatio)
            
            if let ppi = Device.current.ppi?.description {
                ListParameter("Pixel density", parameter: "\(ppi) PPI")
            }
            
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
            let value = CGFloat(newValue / 100)
            setDeviceBrightness(value)
        }
    }
    
    private func setDeviceBrightness(_ level: CGFloat) {
        UIScreen.main.brightness = level
    }
}

#Preview {
    DisplaySpecs()
}
