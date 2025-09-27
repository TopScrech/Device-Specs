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
            
            ListParam("Refresh rate", param: vm.refreshRate)
            
            Section {
                ListParam("Brightness", param: "\(Int(brightness))%")
            }
        }
        .navigationTitle("Display")
        .refreshableTask {
            vm.fetchScreenResolution()
        }
    }
}

#Preview {
    NavigationStack {
        DisplaySpecs()
    }
    .darkSchemePreferred()
}
