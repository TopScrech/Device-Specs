import SwiftUI

@Observable
final class NavState {
    var path = NavigationPath()
    
    func navigate(_ navDestination: NavDestinations) {
        path.append(navDestination)
    }
    
    func dismiss() {
        path.removeLast()
    }
}
