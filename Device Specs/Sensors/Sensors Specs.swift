import ScrechKit

struct SensorsSpecs: View {
    @State private var orientation = OrientationVM()
    @State private var altitude = AltitudeVM()
    @State private var pressure = PressureVM()
    @State private var activity = ActivityVM()
    @State private var proximity = ProximityVM()
    
    var body: some View {
        List {
            ListParam("Proximity sensor triggered", param: proximity.isDeviceCloseToUser ? "Yes" : "No")
            
            LocationSensors()
            
            Section("Rotation") {
                ListParam("Roll", param: orientation.roll)
                ListParam("Pitch", param: orientation.pitch)
                ListParam("Yaw", param: orientation.yaw)
                ListParam("Orientation", param: orientation.orientation)
            }
            
            Section("Acceleration") {
                ListParam("X Axis", param: orientation.x)
                ListParam("Y Axis", param: orientation.y)
                ListParam("Z Axis", param: orientation.z)
            }
            
            Section("Altimeter") {
                if let pressure = pressure.pressureKilo {
                    ListParam("Pressure", param: pressure)
                }
                
                ListParam("Relative altitude", param: altitude.relativeAltitude)
                ListParam("Absolute altitude", param: altitude.absoluteAltitude)
            }
            
            MagneticFieldData()
            
            Section("Motion coprocessor") {
                ListParam("Activity", param: activity.activity)
                ListParam("Confidence", param: activity.confidence)
            }
        }
        .navigationTitle("Sensors")
        .monospacedDigit()
        .scrollIndicators(.never)
    }
}

#Preview {
    NavigationStack {
        SensorsSpecs()
    }
}
