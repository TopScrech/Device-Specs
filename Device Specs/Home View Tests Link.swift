import SwiftUI

struct HomeViewTestsLink: View {
    @Environment(NavState.self) private var nav
    
    var body: some View {
        Section {
            Button {
                nav.navigate(.toTests)
            } label: {
                HStack {
                    Label("Tests", systemImage: "testtube.2")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .caption(.semibold)
                        .tertiary()
                }
            }
            .foregroundStyle(.foreground)
        }
    }
}

#Preview {
    List {
        HomeViewTestsLink()
    }
    .environment(NavState())
}
