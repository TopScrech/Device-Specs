import SwiftUI
import Messages

struct AppContainer: View {
    @State private var vm: MessagesVM
    
    @Binding private var vc: MessagesViewController?
    
    init(_ vc: Binding<MessagesViewController?>) {
        _vc = vc
        self.vm = .init(vc.wrappedValue)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HomeView()
            }
//            .toolbarBackgroundVisibility(.visible)
        }
    }
}
