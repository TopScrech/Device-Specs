import SwiftUI

struct ColorView: View {
    private let color: Color
    
    init(_ color: Color) {
        self.color = color
    }
    
    var body: some View {
        color
            .ignoresSafeArea()
#if os(iOS) || os(visionOS)
            .statusBarHidden(true)
#endif
    }
}

#Preview {
    ColorView(.red)
        .darkSchemePreferred()
}
