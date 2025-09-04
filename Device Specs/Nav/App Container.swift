import SwiftUI

struct AppContainer: View {
    @Environment(NavState.self) private var nav
    @EnvironmentObject private var store: ValueStore
    
    var body: some View {
        @Bindable var nav = nav
        
        NavigationStack(path: $nav.path) {
            HomeView()
                .withNavDestinations()
        }
        .statusBarHidden(!store.showStatusBar)
        .preferredColorScheme(store.appearance.scheme)
    }
}
