import SwiftUI

struct IPhoneListView: View {
    @State private var model = IPhoneListVM()

    var body: some View {
        NavigationSplitView {
            IPhoneSidebarView()
        } detail: {
            if let phone = model.selectedPhone {
                IPhoneDetailView(phone: phone)
            } else {
                ContentUnavailableView(String("Select an iPhone"), systemImage: "iphone")
            }
        }
        .environment(model)
    }
}
