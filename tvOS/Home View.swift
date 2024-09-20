import ScrechKit

struct HomeView: View {
    @State private var processor = ProcessorVM()
    @State private var display = DisplayVM()
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var memory = MemoryVM()
    @State private var connectivity = ConnectivityVM()
    
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
            
            SpecsLink("Network", icon: "network", spec: connectivity.type) {
                NetworkSpecs()
                    .environment(connectivity)
            }
            
            SpecsLink("Accessibility", icon: "accessibility") {
                AccessibilityView()
            }
            
            Section {
                SpecsLink("Tests", icon: "testtube.2") {
                    TestList()
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
    .environment(ProcessorVM())
    .environment(DisplayVM())
    .environment(SystemVM())
    .environment(DeviceVM())
    .environment(MemoryVM())
    .environment(ConnectivityVM())
}
