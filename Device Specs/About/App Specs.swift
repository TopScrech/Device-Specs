import ScrechKit

struct AppSpecs: View {
    @Environment(AppVM.self) private var vm
    
    @State private var sheetPrivacy = false
    @State private var sheetBh = false
    
    private let privacyUrl = "https://topscrech.dev/privacy.pdf"
    private let moreAppsUrl = "https://apps.apple.com/au/developer/sergei-saliukov/id1639409936"
    
    var body: some View {
        List {
            Section {
                Image(.icon)
                    .resizable()
                    .frame(200)
                    .clipShape(.rect(cornerRadius: 16))
                    .shadow(color: .black, radius: 5)
                    .frame(maxWidth: .infinity)
            }
            .listRowBackground(Color.clear)
            .onTapGesture {
                vm.trigger.toggle()
            }
            
            ListParam("App version", param: vm.versionAndBuild)
            
            if let date = vm.getAppInstallationDate {
                ListParam("Installation date", param: date)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Bundle id")
                
                Text(vm.bundleId)
                    .secondary()
            }
            
#if !os(watchOS) && !os(tvOS)
            MailFeedback()
            
            Section {
                Button("Powered by Bisquit.Host") {
                    sheetBh = true
                }
                
                if let url = URL(string: moreAppsUrl) {
                    Link("More apps", destination: url)
                }
                
                Button("Privacy Policy") {
                    sheetPrivacy = true
                }
            }
#endif
        }
        .navigationTitle("About")
        .safariCover($sheetBh, url: "https://bisquit.host")
        .safariCover($sheetPrivacy, url: privacyUrl)
#if !os(visionOS)
        .sensoryFeedback(.impact, trigger: vm.trigger)
#endif
    }
}

#Preview {
    AppSpecs()
        .environment(AppVM())
}
