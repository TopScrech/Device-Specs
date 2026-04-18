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
            LabeledContent("Refresh rate", value: DisplayVM.refreshRate)
            
            Section {
                LabeledContent("Brightness", value: "\(Int(brightness))%")
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
