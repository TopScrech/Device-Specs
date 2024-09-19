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
            
            ListParameter("Refresh rate", parameter: vm.refreshRate)
            
            Section {
                ListParameter("Brightness", parameter: "\(Int(brightness))%")
            }
        }
        .navigationTitle("Display")
        .refreshableTask {
            vm.fetchScreenResolution()
        }
    }
}

#Preview {
    DisplaySpecs()
}
