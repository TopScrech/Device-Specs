import SwiftUI

struct FontList: View {
    @State private var vm = FontVM()
    
    var body: some View {
        List {
#if os(tvOS)
            Section {
                FontCustomization()
            }
            .padding(.vertical, 30)
#endif
            ForEach(vm.filteredFonts, id: \.self) { font in
                FontRow(font)
            }
        }
        .environment(vm)
        .navigationTitle("System fonts")
        .scrollIndicators(.never)
        .animation(.default, value: vm.filteredFonts)
        .searchable(text: $vm.searchText)
#if !os(tvOS)
        .toolbar {
            FontCustomization()
                .environment(vm)
        }
#endif
    }
}

#Preview {
    FontList()
}
