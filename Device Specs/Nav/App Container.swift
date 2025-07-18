import SwiftUI

struct AppContainer: View {
    @Environment(NavState.self) private var navState
    
    @State private var statusBarHidden = false
    
    var body: some View {
        @Bindable var navState = navState
        
        NavigationStack(path: $navState.path) {
            HomeView()
                .withNavDestinations()
#if DEBUG
                .toolbar {
                    if !statusBarHidden {
                        Menu {
                            Button("Hide status bar and this menu") {
                                statusBarHidden = true
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                    }
                }
#endif
        }
        .statusBarHidden(statusBarHidden)
    }
}
