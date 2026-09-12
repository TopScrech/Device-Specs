import Foundation
import ChitChat

struct DeviceChatMessage: Identifiable {
    let id = UUID()
    let role: ChatMessageRole
    var text: String
    var name: String?

    init(role: ChatMessageRole, text: String, name: String? = nil) {
        self.role = role
        self.text = text
        self.name = name
    }

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
