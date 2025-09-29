import Testing
import Foundation

struct UnitTests {
    @Test func example() async throws {
        let accessibilityInfo = parseAccessibilityInfo(from: accessibilityString)
        
        for (key, value) in accessibilityInfo {
            print("\(key): \(value)")
        }
        
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
}

func parseAccessibilityInfo(from input: String) -> [String: String] {
    var result = [String: String]()
    var isInAccessibilitySection = false
    let lines = input.components(separatedBy: "\n")
    
    for line in lines {
        let trimmedLine = line.trimmingCharacters(in: .whitespaces)
        
        // Check if we've reached the "Accessibility Information" section
        if trimmedLine == "Accessibility Information:" {
            isInAccessibilitySection = true
            continue
        }
        
        // Exit parsing if we reach a new main section
        if isInAccessibilitySection && !trimmedLine.isEmpty && !trimmedLine.contains(":") && !trimmedLine.hasPrefix("Accessibility") {
            break
        }
        
        // Parse key-value pairs within the section
        if isInAccessibilitySection, let colonRange = trimmedLine.range(of: ":") {
            let key = String(trimmedLine[..<colonRange.lowerBound]).trimmingCharacters(in: .whitespaces)
            let value = String(trimmedLine[colonRange.upperBound...]).trimmingCharacters(in: .whitespaces)
            
            result[key] = value
        }
    }
    return result
}

// Example usage
let accessibilityString = """
Accessibility:

    Accessibility Information:

      Cursor Magnification: Off
      Display: Black on White
      Flash Screen: Off
      Mouse Keys: Off
      Slow Keys: Off
      Sticky Keys: Off
      VoiceOver: Off
      Zoom Mode: Full Screen
      Contrast: 0
      Keyboard Zoom: On
      Scroll Zoom: Off
"""
