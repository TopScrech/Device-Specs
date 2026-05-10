import SwiftUI

@Observable
final class AppRouter {
    private(set) var actionRequest = 0
    private var pendingAction: HomeAction?
    
    static let shared = AppRouter()
    
#if os(iOS)
    func handle(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        guard let action = HomeAction(shortcutItem: shortcutItem) else {
            return false
        }
        
        request(action)
        return true
    }
#endif
    
    func consumePendingAction() -> HomeAction? {
        let action = pendingAction
        pendingAction = nil
        
        return action
    }
    
    private func request(_ action: HomeAction) {
        pendingAction = action
        actionRequest += 1
    }
}
