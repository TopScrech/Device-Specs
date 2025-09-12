import ScrechKit

struct SocialProfile: Identifiable {
    let link: String
    let img: ImageResource
    
    var id: String {
        link
    }
    
    init(_ link: String, img: ImageResource) {
        self.link = link
        self.img = img
    }
}

struct AboutView: View {
    @Environment(AppVM.self) private var vm
    
    private let links: [SocialProfile] = [
        .init("https://t.me/TopScrech", img: .telegram),
        .init("https://github.com/TopScrech", img: .gitHub),
        .init("https://www.linkedin.com/in/topscrech", img: .linkedIn)
    ]
    
    var body: some View {
        VStack {
            Image(.icon)
                .resizable()
                .frame(200)
                .clipShape(.rect(cornerRadius: 16))
                .shadow(color: .black, radius: 5)
                .frame(maxWidth: .infinity)
                .sensoryFeedback(.impact, trigger: vm.trigger)
                .onTapGesture {
                    vm.trigger.toggle()
                }
            
            Text(vm.versionAndBuild)
                .title2(.bold, design: .rounded)
            
            Spacer()
            
            Text("Get in touch")
                .title3(.semibold, design: .rounded)
                .secondary()
            
            HStack(spacing: 16) {
                ForEach(links) {
                    Image($0.img)
                        .resizable()
                        .frame(40)
                }
            }
            .padding()
            .background(.ultraThinMaterial, in: .capsule)
#warning("glassEffect")
            //            .glassEffect()
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
}
