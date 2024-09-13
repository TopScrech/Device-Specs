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
            
#if !os(watchOS)
            ListParameter("Refresh rate", parameter: display.refreshRate)
            
            ListParameter("Rounded corners", parameter: display.isRounded)
#endif
            
            Section {
                ListParameter("Brightness", parameter: "\(Int(brightness))%")
                
#if !os(watchOS)
                Slider(value: $brightness, in: 0...100, step: 1) {
                    Text("Brightness")
                }
#endif
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
#if !os(watchOS)
        UIScreen.main.brightness = level
#endif
    }
}

#Preview {
    DisplaySpecs()
}
