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
            
            ListParameter("App version", parameter: vm.version)
            
            ListParameter("Build number", parameter: vm.build)
            
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
        .sensoryFeedback(.impact, trigger: vm.trigger)
    }
}

#Preview {
    AppSpecs()
        .environment(AppVM())
}
