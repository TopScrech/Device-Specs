import FoundationModels

@Generable
@available(iOS 26, *)
struct SystemInfo {
    @Guide(description: "Name & version of the operating system on this device")
    let os: String
}
