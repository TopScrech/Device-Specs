import SwiftUI

struct FontRow: View {
    @Environment(FontVM.self) private var vm
    
    private let font: String
    
    init(_ font: String) {
        self.font = font
    }
    
    var body: some View {
#if os(tvOS)
        Button {
            
        } label: {
            label
        }
#else
        label
#endif
    }
    
    private var label: some View {
        HStack {
            Text(font)
            
            Spacer()
            
            Text("Example")
                .bold(vm.isBold)
                .italic(vm.isItalic)
                .underline(vm.isUnderline)
                .strikethrough(vm.isStrikethrough)
#if os(tvOS)
                .font(.custom(font, size: 32))
#else
                .font(.custom(font, size: 16))
#endif
                .animation(.default, value: vm.isUnderline)
                .animation(.default, value: vm.isStrikethrough)
        }
    }
}

#Preview {
    FontRow("Zapfino")
        .environment(FontVM())
}
