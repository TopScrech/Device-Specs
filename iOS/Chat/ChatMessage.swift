import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: ChatMessageRole
    var text: String
    
    var renderedText: AttributedString {
        do {
            return try AttributedString(
                markdown: text,
                options: AttributedString.MarkdownParsingOptions(
                    interpretedSyntax: .inlineOnlyPreservingWhitespace,
                    failurePolicy: .returnPartiallyParsedIfPossible
                )
            )
        } catch {
            return AttributedString(text)
        }
    }
}
