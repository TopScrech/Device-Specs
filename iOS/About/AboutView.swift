import ScrechKit

struct AboutView: View {
    @Environment(AppVM.self) private var vm
    
    private let links: [SocialProfile] = [
        .init("https://t.me/TopScrech", img: .telegram),
        .init("https://github.com/TopScrech", img: .gitHub),
        .init("https://linkedin.com/in/topscrech", img: .linkedIn)
    ]
    
    var body: some View {
        VStack {
            let image = Image(.icon)
                .resizable()
                .frame(200)
                .clipShape(.rect(cornerRadius: 16))
                .shadow(color: .black, radius: 5)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    vm.trigger.toggle()
                }
            
            if #available(visionOS 26, *) {
                image
                    .hapticOn(vm.trigger, as: .impact)
            } else {
                image
            }
            
            Text(vm.versionAndBuild)
                .title2(.bold, design: .rounded)
            
            Spacer()
            
#if !os(tvOS) && !os(watchOS)
            Text("Get in touch")
                .title3(.semibold, design: .rounded)
                .secondary()
            
            HStack(spacing: 16) {
                ForEach(links) { link in
                    if let url = URL(string: link.link) {
                        Link(destination: url) {
                            Image(link.img)
                                .resizable()
                                .frame(40)
                        }
                    }
                }
            }
            .padding()
            .glassyBackground()
#endif
        }
        .padding(.vertical)
        .background {
            Image(.background)
                .resizable()
                .ignoresSafeArea()
        }
#if !os(tvOS)
        .toolbar {
            ShareLink(item: URL(string: "https://apps.apple.com/app/id6624303981")!)
        }
#endif
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
    .environment(AppVM())
    .darkSchemePreferred()
}
