import SwiftUI

struct AppContainer: View {
    @Environment(NavState.self) private var nav
    @EnvironmentObject private var store: ValueStore
    
    private let router = AppRouter.shared
    @State private var assistantRequest = 0
    
    var body: some View {
        @Bindable var nav = nav
        
        NavigationStack(path: $nav.path) {
            HomeView(assistantRequest: assistantRequest)
                .withNavDestinations()
        }
        .statusBarHidden(!store.showStatusBar)
        .preferredColorScheme(store.appearance.scheme)
        .task(id: router.actionRequest) {
            guard
                router.actionRequest > 0,
                let action = router.consumePendingAction()
            else {
                return
            }
            
            switch action {
            case .openAssistant:
                assistantRequest += 1
            }
        }
    }
}
