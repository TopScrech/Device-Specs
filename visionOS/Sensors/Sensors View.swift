import ScrechKit

struct SensorsView: View {
    private var location = LocationVM()
    private var orientation = OrientationVM()
    private var altitude = AltitudeVM()
    
    var body: some View {
        List {
            Section("Location") {
                ListParam("Latitude", param: String(location.latitude))
                ListParam("Longitude", param: String(location.longitude))
            }
            
            Section("Rotation") {
                ListParam("Roll", param: orientation.roll)
                ListParam("Pitch", param: orientation.pitch)
                ListParam("Yaw", param: orientation.yaw)
            }
            
            Section("Acceleration") {
                ListParam("X Axis", param: orientation.x)
                ListParam("Y Axis", param: orientation.y)
                ListParam("Z Axis", param: orientation.z)
            }
            
            Section("Altimeter") {
                ListParam("Absolute altitude", param: altitude.absoluteAltitude)
            }
        }
        .numericTransition()
        .navigationTitle("Sensors")
    }
}

#Preview {
    NavigationStack {
        SensorsView()
    }
    .darkSchemePreferred()
}
