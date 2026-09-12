import SwiftUI

struct PreferredLanguagesView: View {
    private let langs: [String]
    
    init(_ langs: [String]) {
        self.langs = langs
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Text("Preferred languages")
            
            Spacer()
            
            VStack {
                ForEach(langs, id: \.self) {
                    Text($0)
                }
            }
            .secondary()
        }
    }
}

#Preview {
    List {
        PreferredLanguagesView(["English", "Dutch"])
    }
    .darkSchemePreferred()
}
