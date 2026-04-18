import FoundationModels

@Generable
@available(iOS 26, *)
struct StreamResponse {
    let title: String
    let summary: String
    let keyPoints: [String]
}
