import SwiftUI

struct ColorView: View {
    private let color: Color
    
    init(_ color: Color) {
        self.color = color
    }
    
    var body: some View {
        color
            .ignoresSafeArea()
#if !os(watchOS) && !os(tvOS)
            .statusBar(hidden: true)
#endif
    }
}

#Preview {
    ColorView(.red)
}
