import ScrechKit

struct AppSpecs: View {
    @Environment(AppVM.self) private var vm
    
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
                vm.trigger.toggle()
            }
            
            ListParam("App version", param: vm.version)
            
            ListParam("Build", param: vm.build)
            
            if let date = vm.getAppInstallationDate?.formatted() {
                ListParam("Installation date", param: date)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Bundle identifier")
                
                Text(vm.bundleIdentifier)
                    .secondary()
            }
            
#if !os(watchOS) && !os(tvOS)
            MailFeedback()
            
            Section {
                if let url = URL(string: "https://apps.apple.com/au/developer/sergei-saliukov/id1639409936") {
                    Link("More apps", destination: url)
                }
                
                if let url = URL(string: "https://topscrech.dev/bisquit.host/privacy.pdf") {
                    Link("Privacy Policy", destination: url)
                }
            }
#endif
        }
#if !os(visionOS)
        .sensoryFeedback(.impact, trigger: vm.trigger)
#endif
    }
}

#Preview {
    AppSpecs()
        .environment(AppVM())
}
