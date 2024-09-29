import SwiftUI

@Observable
final class FontVM {
    private let fontFamilies = UIFont.familyNames
    
    var searchText = ""
    var isBold = false
    var isItalic = false
    var isUnderline = false
    var isStrikethrough = false
    
    var filteredFonts: [String] {
        if searchText.isEmpty {
            fontFamilies
        } else {
            fontFamilies.filter {
                $0.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
