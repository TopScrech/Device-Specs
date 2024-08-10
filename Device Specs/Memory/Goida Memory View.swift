import ScrechKit

struct Goida_Memory_View: View {
    private var storage = StorageVM()
    private var memory = MemoryVM()
    
    var body: some View {
        List {
            Section("Storage") {
                ListParameter("Total storage", parameter: storage.total)
                ListParameter("Available storage", parameter: storage.available)
            }
            
            Section("RAM") {
                ListParameter("Total RAM", parameter: formatBytes(memory.totalMemory, countStyle: .memory))
                ListParameter("Used RAM", parameter: formatBytes(memory.usedMemory, countStyle: .memory))
                ListParameter("Free RAM", parameter: formatBytes(memory.freeMemory, countStyle: .memory))
            }
        }
        .navigationTitle("Memory")
    }
}

#Preview {
    Goida_Memory_View()
}
