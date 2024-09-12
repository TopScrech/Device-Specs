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
            
            ListParameter("Screen size", parameter: display.diagonalSize)
            
            ListParameter("Aspect ratio", parameter: display.aspectRatio)
            
            ListParameter("Pixel density", parameter: display.dencity)
            
            ListParameter("Refresh rate", parameter: display.refreshRate)
            
            ListParameter("Rounded corners", parameter: display.isRounded)
            
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
        .refreshableTask {
            display.fetchScreenResolution()
        }
    }
    
    private func setDeviceBrightness(_ level: CGFloat) {
        UIScreen.main.brightness = level
    }
}

#Preview {
    DisplaySpecs()
}
