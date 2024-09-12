import ScrechKit

struct SensorsView: View {
    private var location = LocationVM()
    private var orientation = OrientationVM()
    private var altitude = AltitudeVM()
    
    var body: some View {
        List {
            Section("Location") {
                ListParameter("Latitude", parameter: String(location.latitude))
                ListParameter("Longitude", parameter: String(location.longitude))
            }
            
            Section("Rotation") {
                ListParameter("Roll", parameter: orientation.roll)
                ListParameter("Pitch", parameter: orientation.pitch)
                ListParameter("Yaw", parameter: orientation.yaw)
            }
            
            Section("Acceleration") {
                ListParameter("X Axis", parameter: orientation.x)
                ListParameter("Y Axis", parameter: orientation.y)
                ListParameter("Z Axis", parameter: orientation.z)
            }
            
            Section("Altimeter") {
                ListParameter("Absolute altitude", parameter: altitude.absoluteAltitude)
            }
        }
        .numericTransition()
        .navigationTitle("Sensors")
    }
}

#Preview {
    SensorsView()
}
