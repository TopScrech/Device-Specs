import SwiftUI

struct NavLinks: View {
    var body: some View {
        List {
            NavigationLink("Hardware") {
                HardwareView()
            }
            
            NavigationLink("Battery") {
                BatterySpecs()
            }
            
            Section {
                NavigationLink("Full system report") {
                    FullReportView()
                }
            }
        }
    }
}

#Preview {
    NavLinks()
}
