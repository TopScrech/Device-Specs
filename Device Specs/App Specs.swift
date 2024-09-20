import ScrechKit

struct AppSpecs: View {
    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
    }
    
    private var build: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "-"
    }
    
    private var minimumOSVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "MinimumOSVersion") as? String ?? "Unknown"
    }
    
    @State private var trigger = false
    
    var body: some View {
        List {
            Section {
                Image(.icon)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(.rect(cornerRadius: 16))
                    .shadow(color: .black, radius: 5)
                    .frame(maxWidth: .infinity)
            }
            .listRowBackground(Color.clear)
            .onTapGesture {
                trigger.toggle()
            }
            
            ListParameter("App version", parameter: version)
            
            ListParameter("Build number", parameter: build)
            
            Section {
                if let url = URL(string: "https://topscrech.dev/bisquit.host/privacy.pdf") {
                    Link("Privacy Policy", destination: url)
                }
            }
            
            Section {
                if let url = URL(string: "https://apps.apple.com/au/developer/sergei-saliukov/id1639409936") {
                    Link("More apps", destination: url)
                }
            }
        }
        .sensoryFeedback(.impact, trigger: trigger)
    }
}

#Preview {
    AppSpecs()
}
