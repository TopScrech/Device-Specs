import ScrechKit
import DeviceKit

struct DisplaySpecs: View {
    @Environment(DisplayVM.self) private var vm
    
    @State private var brightness = 0.0
    
    init() {
        _brightness = State(initialValue: Double(Device.current.screenBrightness))
    }
    
    var body: some View {
        List {
            ListParameter("Screen resolution", parameter: vm.resolution)
            
            ListParameter("Screen size", parameter: vm.diagonalSize)
            
            ListParameter("Aspect ratio", parameter: vm.aspectRatio)
            
            ListParameter("Pixel density", parameter: vm.dencity)
            
#if !os(watchOS)
            ListParameter("Refresh rate", parameter: vm.refreshRate)
#endif
            
#if os(iOS)
            ListParameter("Rounded corners", parameter: vm.isRounded)
#endif
            
            Section {
                ListParameter("Brightness", parameter: "\(Int(brightness))%")
                
#if !os(watchOS) && !EXTENSION
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
            vm.fetchScreenResolution()
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
        .environment(DisplayVM())
}
