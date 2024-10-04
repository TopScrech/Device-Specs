import Foundation
import LocalAuthentication

@Observable
final class AuthVM {
    private let context = LAContext()
    
    var isAuthenticated = false
    var type = ""
    var icon = ""
    
    var errorMessage = ""
    var alertError = false
    
    init() {
        getBiometryType()
    }
    
#warning("Reused func")
    func getBiometryType() {
        if #available(watchOS 11, *) {
            switch context.biometryType {
            case .faceID:
                icon = "faceid"
                type = "Face ID"
                
            case .touchID:
                icon = "touchid"
                type = "Touch ID"
                
            case .opticID:
                icon = "opticid"
                type = "Optic ID"
                
            case .none:
                icon = ""
                type = "None"
                
            default:
                icon = ""
                type = "Unknown"
            }
        } else {
            icon = ""
            type = "None"
        }
    }
    
    func checkAvailability() {
        //        if #available(watchOS 11, *) {
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authenticate()
        } else {
            errorMessage = error?.localizedDescription ?? "Unknown error"
            alertError = true
            return
        }
        //        }
    }
    
    private func authenticate() {
        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "This is a security check reason."
        ) { success, error in
            if success {
                self.isAuthenticated = true
            } else {
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                self.alertError = true
            }
        }
    }
}
