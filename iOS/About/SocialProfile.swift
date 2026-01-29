import SwiftUI

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
