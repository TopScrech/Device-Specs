import SwiftUI

struct AppContainer: View {
    @Environment(NavState.self) private var nav
    
    @State private var statusBarHidden = false
    
    var body: some View {
        @Bindable var nav = nav
        
        NavigationStack(path: $nav.path) {
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
