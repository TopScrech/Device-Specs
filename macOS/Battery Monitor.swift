import SwiftUI

@Observable
final class BatteryVM {
    var cycleCount = 0

    init() {
        fetchBatteryCycleCount()
    }

    func fetchBatteryCycleCount() {
        DispatchQueue.global(qos: .background).async {
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
                    return
                }
            }

            // Retrieve the properties of the battery
            var properties: Unmanaged<CFMutableDictionary>?
            let result = IORegistryEntryCreateCFProperties(serviceObject, &properties, kCFAllocatorDefault, 0)
            IOObjectRelease(serviceObject)
            if result != KERN_SUCCESS {
                print("Failed to retrieve battery properties.")
                return
            }

            // Extract the cycle count from the properties
            if let props = properties?.takeRetainedValue() as NSDictionary? {
                if let cycleCount = props["CycleCount"] as? Int {
                    DispatchQueue.main.async {
                        self.cycleCount = cycleCount
                    }
                } else {
                    print("Cycle count not found in battery properties.")
                }
            } else {
                print("Battery properties could not be read.")
            }
        }
    }
}
