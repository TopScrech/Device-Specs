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
            ListParam("Screen resolution", param: vm.resolution)
            
            ListParam("Screen size", param: vm.diagonalSize)
            
            ListParam("Aspect ratio", param: vm.aspectRatio)
            
            ListParam("Pixel density", param: vm.dencity)
            
#if !os(watchOS)
            ListParam("Refresh rate", param: vm.refreshRate)
#endif
            
#if os(iOS)
            ListParam("Rounded corners", param: vm.isRounded)
#endif
            
            Section {
                ListParam("Brightness", param: "\(Int(brightness))%")
                
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
#if !os(watchOS)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            withAnimation {
                brightness = Double(Device.current.screenBrightness)
            }
        }
#endif
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
