import SwiftUI

struct ColorTestView: View {
    private let color: Color
    
    init(_ color: Color) {
        self.color = color
    }
    
    var body: some View {
        color
            .ignoresSafeArea()
            .statusBar(hidden: true)
    }
}

#Preview {
    ColorTestView(.red)
}
