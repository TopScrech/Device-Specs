import ScrechKit

struct SensorsView: View {
    private var location = LocationVM()
    private var orientation = OrientationVM()
    private var altitude = AltitudeVM()
    private var pressure = PressureVM()
    private var activity = ActivityVM()
    
    var body: some View {
        List {
            Section("Location") {
                ListParam("Latitude", param: String(location.latitude))
                ListParam("Longitude", param: String(location.longitude))
                
                HStack {
                    Text("True heading")
                    
                    Spacer()
                    
                    let trueHeading = location.trueHeading
                    
                    Image(systemName: "arrow.up.circle")
                        .semibold()
                        .title3()
                        .foregroundColor((trueHeading >= 355 || trueHeading <= 5) ? .green : .primary)
                        .rotationEffect(.degrees(trueHeading))
                    
                    Text(String(format: "%.1f", trueHeading) + "°")
                        .secondary()
                }
                
                HStack {
                    Text("Magnetic heading")
                    
                    Spacer()
                    
                    let magneticHeading = location.magneticHeading
                    
                    Image(systemName: "arrow.up.circle")
                        .semibold()
                        .title3()
                        .foregroundColor((magneticHeading >= 355 || magneticHeading <= 5) ? .green : .primary)
                        .rotationEffect(.degrees(magneticHeading))
                    
                    Text(String(format: "%.1f", magneticHeading) + "°")
                        .secondary()
                }
                
                ListParam("Heading accuracy", param: String(location.headingAccuracy) + "°")
            }
            
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
                ListParam("Pressure", param: pressure.pressureKilo)
                ListParam("Relative altitude", param: altitude.relativeAltitude)
                ListParam("Absolute altitude", param: altitude.absoluteAltitude)
            }
            
            Section("Magnetic field") {
                MagneticFieldData()
            }
            
            Section("Motion coprocessor") {
                ListParam("Activity", param: activity.activity)
                ListParam("Confidence", param: activity.confidence)
            }
        }
        .numericTransition()
        .navigationTitle("Sensors")
    }
}

#Preview {
    SensorsView()
}
