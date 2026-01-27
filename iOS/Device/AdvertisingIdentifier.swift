//import SwiftUI
//import AdSupport
//import AppTrackingTransparency
//
//struct AdvertisingIdentifier: View {
//    private var idfa: String {
//        let identifier = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//        
//        if identifier == "00000000-0000-0000-0000-000000000000" {
//            return "N/a"
//        } else {
//            return identifier
//        }
//    }
//    
//    private func request() {
//        ATTrackingManager.requestTrackingAuthorization { status in
//            switch status {
//            case .notDetermined:
//                logger.info("Not determined")
//                
//            case .restricted:
//                logger.warning("Restricted")
//                
//            case .denied:
//                logger.warning("Denied")
//                openSettings()
//                
//            case .authorized:
//                logger.info("Authorized")
//                
//            default:
//                logger.warning("Unknown")
//            }
//        }
//    }
//    
//    private func isTrackingAccessAvailable() -> Bool {
//        switch ATTrackingManager.trackingAuthorizationStatus {
//        case .authorized:
//            true
//            
//        case .notDetermined, .restricted, .denied:
//            false
//            
//        default:
//            false
//        }
//    }
//    
//    var body: some View {
//        Section {
//            LabeledContent("Advertising Identifier (IDFA)", value: idfa)
//        } footer: {
//            if idfa == "N/a" {
//                Button("Request IDFA") {
//                    request()
//                }
//                .footnote()
//            }
//        }
//    }
//}
//
//#Preview {
//    AdvertisingIdentifier()
//.darkSchemePreferred()
//}
