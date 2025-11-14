import SwiftUI

struct NavLinks: View {
    var body: some View {
        List {
            NavLink("Hardware", icon: "pc") {
                HardwareSpecs()
            }
            
            NavLink("Battery", icon: "battery.100percent.bolt") {
                BatterySpecs()
            }
            
            Divider()
            
            NavLink("Full system report", icon: "terminal") {
                SystemReportView()
            }
            
            Spacer()
            
            NavLink("Settings", icon: "gear")
        }
        .padding(10)
    }
}

#Preview {
    NavLinks()
        .darkSchemePreferred()
}
