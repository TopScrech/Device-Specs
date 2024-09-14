import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            NavigationLink("Battery") {
                BatterySpecs()
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
