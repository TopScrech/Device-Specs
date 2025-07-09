import SwiftUI

struct HomeViewTestsLink: View {
    @Environment(NavState.self) private var navState
    
    var body: some View {
        Section {
            Button {
                navState.navigate(.toTests)
            } label: {
                HStack {
                    Label("Tests", systemImage: "testtube.2")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .caption(.semibold)
                        .tertiary()
                }
                .foregroundStyle(.foreground)
            }
        }
    }
}

#Preview {
    HomeViewTestsLink()
        .environment(NavState())
}
