//import ScrechKit
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
//                print("Not Determined")
//                
//            case .restricted:
//                print("Restricted")
//                
//            case .denied:
//                print("Denied")
//                openSettings()
//                
//            case .authorized:
//                print("Authorized")
//                
//            default:
//                print("Unknown")
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
//            ListParam("Advertising Identifier (IDFA)", param: idfa)
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
