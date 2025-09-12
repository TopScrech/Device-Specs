import SwiftUI

struct SecondaryContainer: View {
    @Environment(NavState.self) private var nav
    
    var body: some View {
        @Bindable var nav = nav
        
        NavigationStack(path: $nav.path) {
            HomeView()
                .withNavDestinations()
                .navigationTitle("Device Specs")
        }
    }
}
