import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            NavigationLink("Hardware") {
                HardwareView()
            }
            
            NavigationLink("Battery") {
                BatterySpecs()
            }
            
            NavigationLink("Test") {
                TestView()
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
