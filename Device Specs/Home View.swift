import SwiftUI

struct HomeView: View {
    @Environment(NavState.self) private var navState
    
    @State private var battery = BatteryVM()
    @State private var processor = ProcessorVM()
    @State private var display = DisplayVM()
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var memory = MemoryVM()
    
    var body: some View {
        List {
            SpecsLink("Device", icon: "info.circle", spec: device.deviceIdentifier) {
                DeviceSpecs()
                    .environment(device)
            }
            
            SpecsLink("System", icon: "apple.terminal", spec: system.operatingSystem) {
                SystemSpecs()
                    .environment(system)
            }
            
            SpecsLink("Display", icon: "iphone", spec: display.diagonalSize) {
                DisplaySpecs()
                    .environment(display)
            }
            
            SpecsLink("Processor", icon: "cpu", spec: processor.cpu) {
                ProcessorSpecs()
                    .environment(processor)
            }
            
            SpecsLink("Memory", icon: "memorychip", spec: memory.totalRamAndDisk) {
                MemorySpecs()
                    .environment(memory)
            }
            
            SpecsLink("Battery", icon: "battery.100percent.bolt", spec: battery.batteryLevel) {
                BatterySpecs()
                    .environment(battery)
            }
            .symbolRenderingMode(.multicolor)
            
            SpecsLink("Cameras", icon: "camera") {
                CameraSpecs()
            }
            
            SpecsLink("Network", icon: "network") {
                NetworkSpecs()
            }
            
            SpecsLink("Sensors", icon: "barometer") {
                SensorsView()
            }
            
            SpecsLink("Accessibility", icon: "accessibility") {
                AccessibilityView()
            }
            
            Section {
                Button("Tests") {
                    navState.navigate(.toTests)
                }
                .foregroundStyle(.foreground)
            }
            
            Section {
                NavigationLink("About") {
                    AppSpecs()
                }
            }
        }
        .navigationTitle("Device Specs")
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
    .environment(BatteryVM())
    .environment(ProcessorVM())
    .environment(DisplayVM())
    .environment(SystemVM())
    .environment(DeviceVM())
    .environment(MemoryVM())
    .environment(NavState())
}
