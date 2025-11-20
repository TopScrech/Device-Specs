import SwiftUI
import Messages

@Observable
final class MessagesVM {
    private var vc: MessagesViewController?
    
    init(_ vc: MessagesViewController?) {
        self.vc = vc
    }
    
    var message = "Hello from ViewModel!"
    
    func updateMessage(newMessage: String) {
        message = newMessage
    }
    
    func sendMessage(_ text: String) {
        guard let conversation = vc?.conversation else {
            print("No active conversation")
            return
        }
        
        let layout = MSMessageTemplateLayout()
        layout.caption = "text"
        layout.subcaption = "text"
        layout.image = UIImage(named: "artwork")
        layout.imageTitle = "Luza"
        layout.imageSubtitle = "Flufa"
        layout.trailingCaption = "11"
        layout.trailingSubcaption = "22"
        
        let message = MSMessage()
        message.layout = layout
        
        conversation.insert(message)
        
        conversation.insert(message) { error in
            if let error {
                print("Error sending message:", error.localizedDescription)
            }
        }
    }
}
