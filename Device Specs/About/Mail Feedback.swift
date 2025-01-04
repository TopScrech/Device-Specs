import ScrechKit
import MailCover

struct MailFeedback: View {
    @State private var showMail = false
    
    var body: some View {
        Section {
            ListButton("Feedback", icon: "envelope") {
                showMail = true
            }
        }
        .mailCover($showMail, subject: "Device Specs", recipients: ["topscrech@icloud.com"], alerts: .disabled)
    }
}

#Preview {
    List {
        MailFeedback()
    }
}
