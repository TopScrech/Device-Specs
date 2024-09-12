import ScrechKit

struct MemoryView: View {
    private var storage = StorageVM()
    private var ram = RamVM()
    
    var body: some View {
        List {
            Section("Storage") {
                ListParameter("Total storage", parameter: storage.total)
                ListParameter("Used storage", parameter: storage.used)
                ListParameter("Available storage", parameter: storage.available)
            }
            
            Section("RAM") {
                let totalRam = formatBytes(ram.total, countStyle: .memory)
                let usedRam = formatBytes(ram.used, countStyle: .memory)
                let freeRam = formatBytes(ram.free, countStyle: .memory)
                
                ListParameter("Total RAM", parameter: totalRam)
                ListParameter("Used RAM", parameter: usedRam)
                ListParameter("Free RAM", parameter: freeRam)
            }
        }
        .navigationTitle("Memory")
        .refreshableTask {
            storage.fetchStorageInfo()
            ram.getMemoryUsage()
        }
    }
}

#Preview {
    MemoryView()
}
