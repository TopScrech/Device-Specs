import ScrechKit

struct DisplaySpecs: View {
    private var display = DisplayVM()
    
    var body: some View {
        List {
            Section("Display") {
                ListParameter("Screen resolution", parameter: display.fetchScreenResolution())
                ListParameter("Refresh rate", parameter: display.refreshRate)
                ListParameter("Brightness", parameter: display.brightness)
            }
        }
        .navigationTitle("Display")
    }
}

#Preview {
    DisplaySpecs()
}
