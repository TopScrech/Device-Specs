import Foundation
import LocalAuthentication

@Observable
final class AuthVM {
    private let context = LAContext()
    
    private(set) var isAuthenticated = false
    private(set) var type = ""
    private(set) var icon = ""
    
    private(set) var errorMessage = ""
    var alertError = false
    
    init() {
        getBiometryType()
    }
    
    private func getBiometryType() {
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
#if !os(watchOS)
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authenticate()
        } else {
            errorMessage = error?.localizedDescription ?? "Unknown error"
            alertError = true
            return
        }
#endif
    }
    
    private func authenticate() {
#if !os(watchOS)
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
#endif
    }
}
