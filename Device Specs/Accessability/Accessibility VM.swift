import SwiftUI

@Observable
final class AccessibilityVM {
    var filter = ""
    
    var filteredParams: [AccessibilityParam] {
        if filter.isEmpty {
            return accessibilityParams
        } else {
            let prompt = filter.lowercased()
            
            return accessibilityParams.filter {
                $0.name.lowercased().contains(prompt)
            }
        }
    }
    
    private let accessibilityParams: [AccessibilityParam] = [
        AccessibilityParam("VoiceOver", isEnabled: UIAccessibility.isVoiceOverRunning),
        AccessibilityParam("Reduce Motion", isEnabled: UIAccessibility.isReduceMotionEnabled),
        AccessibilityParam("Reduce Transparency", isEnabled: UIAccessibility.isReduceTransparencyEnabled),
        AccessibilityParam("Button Shapes", isEnabled: UIAccessibility.buttonShapesEnabled),
        AccessibilityParam("Bold Text", isEnabled: UIAccessibility.isBoldTextEnabled),
        AccessibilityParam("Assistive Touch", isEnabled: UIAccessibility.isAssistiveTouchRunning),
        AccessibilityParam("Closed Captioning", isEnabled: UIAccessibility.isClosedCaptioningEnabled),
        AccessibilityParam("Darker System Colors", isEnabled: UIAccessibility.isDarkerSystemColorsEnabled),
        AccessibilityParam("Grayscale", isEnabled: UIAccessibility.isGrayscaleEnabled),
        AccessibilityParam("Guided Access", isEnabled: UIAccessibility.isGuidedAccessEnabled),
        AccessibilityParam("Invert Colors", isEnabled: UIAccessibility.isInvertColorsEnabled),
        AccessibilityParam("Mono Audio", isEnabled: UIAccessibility.isMonoAudioEnabled),
        AccessibilityParam("On/Off Switch Labels", isEnabled: UIAccessibility.isOnOffSwitchLabelsEnabled),
        AccessibilityParam("Shake to Undo", isEnabled: UIAccessibility.isShakeToUndoEnabled),
        AccessibilityParam("Speak Screen", isEnabled: UIAccessibility.isSpeakScreenEnabled),
        AccessibilityParam("Speak Selection", isEnabled: UIAccessibility.isSpeakSelectionEnabled),
        AccessibilityParam("Switch Control", isEnabled: UIAccessibility.isSwitchControlRunning),
        AccessibilityParam("Video Autoplay", isEnabled: UIAccessibility.isVideoAutoplayEnabled),
        AccessibilityParam("Prefers Cross Fade Transitions", isEnabled: UIAccessibility.prefersCrossFadeTransitions),
        AccessibilityParam("Should Differentiate Without Color", isEnabled: UIAccessibility.shouldDifferentiateWithoutColor)
    ]
}
