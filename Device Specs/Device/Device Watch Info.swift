import ScrechKit

struct DeviceWatchInfo: View {
    private var crownOrientation: String {
        switch WKInterfaceDevice.current().crownOrientation {
        case .left: "Left"
        case .right: "Right"
        default: "Unknown"
        }
    }
    
    private var wristLocation: String {
        switch WKInterfaceDevice.current().wristLocation {
        case .left: "Left"
        case .right: "Right"
        default: "Unknown"
        }
    }
    
    private var layoutDirection: String {
        switch WKInterfaceDevice.current().layoutDirection {
        case .leftToRight: "Left to right"
        case .rightToLeft: "Right to left"
        default: "Unknown"
        }
    }
    
    var body: some View {
        Section("Watch Specific") {
            ListParam("Crown orientation", param: crownOrientation)
            ListParam("Water lock", param: WKInterfaceDevice.current().isWaterLockEnabled ? "Yes" : "No")
            ListParam("Layout direction", param: layoutDirection)
            ListParam("Wrist location", param: wristLocation)
        }
    }
}

#Preview {
    List {
        DeviceWatchInfo()
    }
}
