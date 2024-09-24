import SwiftUI

struct FontList: View {
    private let fontFamilies = UIFont.familyNames
    
    @State private var searchText = ""
    @State private var isBold = false
    
    private var filteredFonts: [String] {
        if searchText.isEmpty {
            fontFamilies
        } else {
            fontFamilies.filter {
                $0.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredFonts, id: \.self) { fontFamily in
                HStack {
                    Text(fontFamily)
                    
                    Spacer()
                    
                    Text("Example")
                        .bold(isBold)
                        .font(.custom(fontFamily, size: 16))
                }
            }
        }
        .navigationTitle("System fonts")
        .scrollIndicators(.never)
        .animation(.default, value: filteredFonts)
        .searchable(text: $searchText)
        .toolbar {
            Button {
                isBold.toggle()
            } label: {
                Image(systemName: "bold")
                    .foregroundStyle(isBold ? .primary : .secondary)
            }
        }
    }
}

#Preview {
    FontList()
}
