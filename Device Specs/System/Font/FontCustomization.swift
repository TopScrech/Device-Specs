import ScrechKit

struct FontCustomization: View {
    @Environment(FontVM.self) private var vm
    
    var body: some View {
#if os(tvOS)
        Button("Bold") {
            vm.isBold.toggle()
        }
        .foregroundStyle(vm.isBold ? .primary : .secondary)
        
        Button("Italic") {
            vm.isItalic.toggle()
        }
        .foregroundStyle(vm.isItalic ? .primary : .secondary)
        
        Button("Underline") {
            vm.isUnderline.toggle()
        }
        .foregroundStyle(vm.isUnderline ? .primary : .secondary)
        
        Button("Strikethrough") {
            vm.isStrikethrough.toggle()
        }
        .foregroundStyle(vm.isStrikethrough ? .primary : .secondary)
#else
        SFButton("bold") {
            vm.isBold.toggle()
        }
        .foregroundStyle(vm.isBold ? .primary : .secondary)
        
        SFButton("italic") {
            vm.isItalic.toggle()
        }
        .foregroundStyle(vm.isItalic ? .primary : .secondary)
        
        SFButton("underline") {
            vm.isUnderline.toggle()
        }
        .foregroundStyle(vm.isUnderline ? .primary : .secondary)
        
        SFButton("strikethrough") {
            vm.isStrikethrough.toggle()
        }
        .foregroundStyle(vm.isStrikethrough ? .primary : .secondary)
#endif
    }
}

#Preview {
    FontCustomization()
        .environment(FontVM())
        .darkSchemePreferred()
}
