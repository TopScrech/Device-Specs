import SwiftUI

struct FontList: View {
    private let fontFamilies = UIFont.familyNames
    
    @State private var searchText = ""
    @State private var isBold = false
    @State private var isItalic = false
    @State private var isUnderline = false
    @State private var isStrikethrough = false
    
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
                        .italic(isItalic)
                        .underline(isUnderline)
                        .strikethrough(isStrikethrough)
                        .font(.custom(fontFamily, size: 16))
                        .animation(.default, value: isUnderline)
                        .animation(.default, value: isStrikethrough)
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
            
            Button {
                isItalic.toggle()
            } label: {
                Image(systemName: "italic")
                    .foregroundStyle(isItalic ? .primary : .secondary)
            }
            
            Button {
                isUnderline.toggle()
            } label: {
                Image(systemName: "underline")
                    .foregroundStyle(isUnderline ? .primary : .secondary)
            }
            
            Button {
                isStrikethrough.toggle()
            } label: {
                Image(systemName: "strikethrough")
                    .foregroundStyle(isStrikethrough ? .primary : .secondary)
            }
        }
    }
}

#Preview {
    FontList()
}
