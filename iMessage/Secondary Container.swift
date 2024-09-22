import SwiftUI

struct SecondaryContainer: View {
    @Environment(NavState.self) private var navState
    
    var body: some View {
        @Bindable var binding = navState
        
        NavigationStack(path: $binding.path) {
            HomeView()
                .withNavDestinations()
                .navigationTitle("Device Specs")
        }
    }
}
