import FoundationModels

@Generable
@available(iOS 26, *)
struct SystemInfo {
    @Guide(description: "Name & version of the operating system")
    let os: String
    
    @Guide(description: "Version build number of the operating system")
    let buildNumber: String
}
