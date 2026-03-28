import SwiftUI

struct LocationSensors: View {
    @State private var location = LocationVM()
    
    var body: some View {
        Section("Location") {
            LabeledContent("Latitude", value: String(format: "%.6f", location.latitude))
            LabeledContent("Longitude", value: String(format: "%.6f", location.longitude))
            
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
            
            LabeledContent("Heading accuracy", value: String(format: "%.2f", location.headingAccuracy) + "°")
        }
        .onAppear {
            location.onAppear()
        }
    }
}

#Preview {
    List {
        LocationSensors()
    }
    .darkSchemePreferred()
}
