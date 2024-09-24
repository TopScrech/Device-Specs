import SwiftUI

struct HomeView: View {
    @Environment(NavState.self) private var navState
    
    @State private var battery = BatteryVM()
    @State private var processor = ProcessorVM()
    @State private var display = DisplayVM()
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var memory = MemoryVM()
    @State private var app = AppVM()
    @State private var connectivity = ConnectivityVM()
    @State private var camera = CameraVM()
    
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
            
            SpecsLink("Processor", icon: "cpu", spec: processor.cpuNameAndTechnology) {
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
            
            SpecsLink("Network", icon: "network", spec: connectivity.type) {
                NetworkSpecs()
                    .environment(connectivity)
            }
            
            SpecsLink("Cameras", icon: "camera", spec: camera.hasLidar) {
                CameraSpecs()
                    .environment(camera)
            }
            
            SpecsLink("Sensors", icon: "barometer") {
                SensorsView()
            }
            
            SpecsLink("Accessibility", icon: "accessibility") {
                AccessibilityView()
            }
            
            Section {
                SpecsButton("Tests", icon: "testtube.2") {
                    navState.navigate(.toTests)
                }
            }
            
            Section {
                SpecsLink("About", icon: "questionmark.square.dashed", spec: app.versionAndBuild) {
                    AppSpecs()
                        .environment(app)
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
    .environment(AppVM())
    .environment(ConnectivityVM())
    .environment(CameraVM())
    .environment(NavState())
}
