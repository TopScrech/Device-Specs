import SwiftUI

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
        Button {
            vm.isBold.toggle()
        } label: {
            Image(systemName: "bold")
                .foregroundStyle(vm.isBold ? .primary : .secondary)
        }
        
        Button {
            vm.isItalic.toggle()
        } label: {
            Image(systemName: "italic")
                .foregroundStyle(vm.isItalic ? .primary : .secondary)
        }
        
        Button {
            vm.isUnderline.toggle()
        } label: {
            Image(systemName: "underline")
                .foregroundStyle(vm.isUnderline ? .primary : .secondary)
        }
        
        Button {
            vm.isStrikethrough.toggle()
        } label: {
            Image(systemName: "strikethrough")
                .foregroundStyle(vm.isStrikethrough ? .primary : .secondary)
        }
#endif
    }
}

#Preview {
    FontCustomization()
        .environment(FontVM())
}
