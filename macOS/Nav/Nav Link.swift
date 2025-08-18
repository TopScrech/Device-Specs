import SwiftUI

struct NavLink <Destination: View>: View {
    private let name: LocalizedStringKey
    private let icon: String
    private let destination: Destination
    
    init(_ name: LocalizedStringKey, icon: String, destination: @escaping () -> Destination =  { EmptyView() }) {
        self.name = name
        self.icon = icon
        self.destination = destination()
    }
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack {
                Image(systemName: icon)
                    .frame(width: 30)
                
                Text(name)
                    .rounded()
            }
            
            //            Label {
            //                Text(name)
            //            } icon: {
            //                Image(systemName: icon)
            //                    .foregroundStyle(.primary)
            ////                    .padding(.trailing, 12)
            //            }
            //            .title2()
            //            .padding(.vertical, 2)
        }
    }
}

#Preview {
    List {
        NavLink("Preview", icon: "hammer")
    }
    .darkSchemePreferred()
}
