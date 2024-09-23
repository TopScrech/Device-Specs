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
                "\($0.name)".lowercased().contains(prompt)
            }
        }
    }
    
    private let accessibilityParams: [AccessibilityParam] = [
        .init("VoiceOver",                          isEnabled: UIAccessibility.isVoiceOverRunning),
        .init("Reduce Motion",                      isEnabled: UIAccessibility.isReduceMotionEnabled),
        .init("Reduce Transparency",                isEnabled: UIAccessibility.isReduceTransparencyEnabled),
        .init("Button Shapes",                      isEnabled: UIAccessibility.buttonShapesEnabled),
        .init("Bold Text",                          isEnabled: UIAccessibility.isBoldTextEnabled),
        .init("Assistive Touch",                    isEnabled: UIAccessibility.isAssistiveTouchRunning),
        .init("Closed Captioning",                  isEnabled: UIAccessibility.isClosedCaptioningEnabled),
        .init("Darker System Colors",               isEnabled: UIAccessibility.isDarkerSystemColorsEnabled),
        .init("Grayscale",                          isEnabled: UIAccessibility.isGrayscaleEnabled),
        .init("Guided Access",                      isEnabled: UIAccessibility.isGuidedAccessEnabled),
        .init("Invert Colors",                      isEnabled: UIAccessibility.isInvertColorsEnabled),
        .init("Mono Audio",                         isEnabled: UIAccessibility.isMonoAudioEnabled),
        .init("On/Off Switch Labels",               isEnabled: UIAccessibility.isOnOffSwitchLabelsEnabled),
        .init("Shake to Undo",                      isEnabled: UIAccessibility.isShakeToUndoEnabled),
        .init("Speak Screen",                       isEnabled: UIAccessibility.isSpeakScreenEnabled),
        .init("Speak Selection",                    isEnabled: UIAccessibility.isSpeakSelectionEnabled),
        .init("Switch Control",                     isEnabled: UIAccessibility.isSwitchControlRunning),
        .init("Video Autoplay",                     isEnabled: UIAccessibility.isVideoAutoplayEnabled),
        .init("Prefers Cross Fade Transitions",     isEnabled: UIAccessibility.prefersCrossFadeTransitions),
        .init("Should Differentiate Without Color", isEnabled: UIAccessibility.shouldDifferentiateWithoutColor)
    ]
}
