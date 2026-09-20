import SwiftUI
import Messages

struct AppContainer: View {
    @Binding private var vc: MessagesViewController?
    
    init(_ vc: Binding<MessagesViewController?>) {
        _vc = vc
    }
    
    var body: some View {
        NavigationStack {
            MinimizedHomeView()
        }
    }
}
