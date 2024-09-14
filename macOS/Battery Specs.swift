import SwiftUI

struct BatterySpecs: View {
    var body: some View {
        Button("Test") {
            if let cycleCount = getBatteryCycleCount() {
                print("Battery Cycle Count: \(cycleCount)")
            } else {
                print("Could not retrieve battery cycle count.")
            }
        }
        Text("Hello, World!")
    }
    
    func getBatteryCycleCount() -> Int? {
        // Create a matching dictionary to find the battery service
        let matchingDict = IOServiceMatching("AppleSmartBattery")
        var serviceObject: io_registry_entry_t = 0
        
        // Get the battery service
        serviceObject = IOServiceGetMatchingService(kIOMainPortDefault, matchingDict)
        
        if serviceObject == 0 {
            // If not found, try an alternate battery service name
            let alternateMatchingDict = IOServiceMatching("IOPMPowerSource")
            serviceObject = IOServiceGetMatchingService(kIOMainPortDefault, alternateMatchingDict)
            if serviceObject == 0 {
                print("Battery service not found.")
                return nil
            }
        }
        
        // Retrieve the properties of the battery
        var properties: Unmanaged<CFMutableDictionary>?
        let result = IORegistryEntryCreateCFProperties(serviceObject, &properties, kCFAllocatorDefault, 0)
        IOObjectRelease(serviceObject)
        if result != KERN_SUCCESS {
            print("Failed to retrieve battery properties.")
            return nil
        }
        
        // Extract the cycle count from the properties
        if let props = properties?.takeRetainedValue() as NSDictionary? {
            if let cycleCount = props["CycleCount"] as? Int {
                return cycleCount
            } else {
                print("Cycle count not found in battery properties.")
                return nil
            }
        } else {
            print("Battery properties could not be read.")
            return nil
        }
    }
}

#Preview {
    BatterySpecs()
}
