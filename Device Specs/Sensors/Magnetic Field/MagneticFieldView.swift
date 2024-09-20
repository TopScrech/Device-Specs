import SwiftUI

struct MagneticFieldView: View {
    @State private var vm = MagneticFieldVM()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Magnetic Field Data")
                        .font(.largeTitle)
                        .padding(.top, 20)
                    
                    // Raw Magnetic Field Data
                    GroupBox {
                        if let raw = vm.rawMagneticField {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("Raw X:")
                                    Spacer()
                                    Text(String(format: "%.2f µT", raw.x))
                                        .bold()
                                }
                                
                                HStack {
                                    Text("Raw Y:")
                                    Spacer()
                                    Text(String(format: "%.2f µT", raw.y))
                                        .bold()
                                }
                                
                                HStack {
                                    Text("Raw Z:")
                                    Spacer()
                                    Text(String(format: "%.2f µT", raw.z))
                                        .bold()
                                }
                            }
                            .padding()
                        } else {
                            Text("Raw data not available.")
                                .padding()
                        }
                    } label: {
                        Text("Raw Data")
                            .font(.headline)
                    }
                    .padding([.leading, .trailing], 20)
                    
                    // Calibrated Magnetic Field Data
                    GroupBox {
                        if let calibrated = vm.calibratedMagneticField {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("Calibrated X:")
                                    Spacer()
                                    Text(String(format: "%.2f µT", calibrated.x))
                                        .bold()
                                }
                                
                                HStack {
                                    Text("Calibrated Y:")
                                    Spacer()
                                    Text(String(format: "%.2f µT", calibrated.y))
                                        .bold()
                                }
                                
                                HStack {
                                    Text("Calibrated Z:")
                                    Spacer()
                                    Text(String(format: "%.2f µT", calibrated.z))
                                        .bold()
                                }
                            }
                            .padding()
                        } else {
                            Text("Calibrated data not available.")
                                .padding()
                        }
                    } label: {
                        Text("Calibrated Data")
                            .font(.headline)
                    }
                    .padding([.leading, .trailing], 20)
                    
                    // Heading Data and Accuracy
                    GroupBox {
                        VStack(alignment: .leading, spacing: 10) {
                            if let heading = vm.heading {
                                HStack {
                                    Text("Heading (Magnetic):")
                                    Spacer()
                                    Text(String(format: "%.2f°", heading.magneticHeading))
                                        .bold()
                                }
                            } else {
                                Text("Heading data not available.")
                                    .padding()
                            }
                            
                            // Display authorization status or errors
                            switch vm.authorizationStatus {
                            case .authorizedAlways, .authorizedWhenInUse:
                                if let error = vm.locationError {
                                    Text("Location Error: \(error.localizedDescription)")
                                        .foregroundColor(.red)
                                        .padding()
                                }
                                
                            case .denied, .restricted:
                                Text("Location access denied. Accuracy may be unavailable.")
                                    .foregroundColor(.orange)
                                    .padding()
                                
                            case .notDetermined:
                                Text("Requesting location access...")
                                    .padding()
                                
                            @unknown default:
                                Text("Unknown location status.")
                                    .padding()
                            }
                        }
                        .padding()
                    } label: {
                        Text("Heading Data")
                            .font(.headline)
                    }
                    .padding([.leading, .trailing], 20)
                    
                    Spacer()
                }
            }
            .navigationTitle("Magnetic Field")
        }
    }
}

#Preview {
    MagneticFieldView()
}
