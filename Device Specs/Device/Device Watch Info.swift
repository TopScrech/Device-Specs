import ScrechKit

struct DeviceWatchInfo: View {
    private var crownOrientation: String {
        switch WKInterfaceDevice.current().crownOrientation {
        case .left: "Left"
        case .right: "Right"
        default: "Unknown"
        }
    }
    
    private var waterResistanceRating: String {
        switch WKInterfaceDevice.current().waterResistanceRating {
        case .ipx7: "IPX7"
        case .wr50: "WR50"
        case .wr100: "WR100"
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
            ListParameter("Crown orientation", parameter: crownOrientation)
            ListParameter("Water lock", parameter: WKInterfaceDevice.current().isWaterLockEnabled ? "Yes" : "No")
            ListParameter("Layout direction", parameter: layoutDirection)
            ListParameter("Water resistance rating", parameter: waterResistanceRating)
            ListParameter("Wrist location", parameter: wristLocation)
        }
    }
}

#Preview {
    DeviceWatchInfo()
}
