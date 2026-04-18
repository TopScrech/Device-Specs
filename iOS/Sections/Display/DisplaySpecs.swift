import SwiftUI
import DeviceKit

struct DisplaySpecs: View {
    @Environment(DisplayVM.self) private var vm
    
    @State private var brightness = 0.0
    
    init() {
        _brightness = State(initialValue: Double(Device.current.screenBrightness))
    }
    
    var body: some View {
        List {
            LabeledContent("Screen resolution", value: vm.resolution)
            LabeledContent("Screen size", value: vm.diagonalSize)
            LabeledContent("Aspect ratio", value: DisplayVM.aspectRatio)
            LabeledContent("Pixel density", value: vm.dencity)
#if !os(watchOS)
            LabeledContent("Refresh rate", value: DisplayVM.refreshRate)
#endif
            
#if os(iOS)
            LabeledContent("Rounded corners", value: vm.isRounded)
#endif
            Section {
                LabeledContent("Brightness", value: "\(Int(brightness))%")
                
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
    NavigationStack {
        DisplaySpecs()
    }
    .environment(DisplayVM())
    .darkSchemePreferred()
}
