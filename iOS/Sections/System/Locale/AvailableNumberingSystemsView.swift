import SwiftUI

struct AvailableNumberingSystemsView: View {
    private let numberingSystems: [Locale.NumberingSystem]
    
    init(_ numberingSystems: [Locale.NumberingSystem]) {
        self.numberingSystems = numberingSystems
    }
    
    var body: some View {
        HStack {
            Text("Available numbering systems")
            
            Spacer()
            
            VStack {
                ForEach(numberingSystems, id: \.self) {
                    Text($0.debugDescription)
                        .secondary()
                }
            }
        }
    }
}

#Preview {
    List {
        AvailableNumberingSystemsView(Locale.current.availableNumberingSystems)
    }
    .darkSchemePreferred()
}
