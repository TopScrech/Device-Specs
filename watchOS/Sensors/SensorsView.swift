import ScrechKit

struct SensorsView: View {
    private var orientation = OrientationVM()
    private var altitude = AltitudeVM()
    private var pressure = PressureVM()
    private var activity = ActivityVM()
    
    var body: some View {
        List {
            LocationSensors()
            
            Section("Rotation") {
                ListParam("Roll", param: orientation.roll)
                ListParam("Pitch", param: orientation.pitch)
                ListParam("Yaw", param: orientation.yaw)
#if os(iOS)
                ListParam("Orientation", param: orientation.orientation)
#endif
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
    }
}

#Preview {
    NavigationStack {
        SensorsView()
    }
    .darkSchemePreferred()
}
