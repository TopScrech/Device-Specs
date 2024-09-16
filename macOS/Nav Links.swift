import SwiftUI

struct NavLinks: View {
    var body: some View {
        List {
            NavigationLink("Hardware") {
                HardwareSpecs()
            }
            
            NavigationLink("Battery") {
                BatterySpecs()
            }
            
            Section {
                NavigationLink("Full system report") {
                    SystemReportView()
                }
            }
        }
    }
}

#Preview {
    NavLinks()
}
