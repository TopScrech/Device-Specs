import ScrechKit
import HealthKit

struct HealthKit: View {
    private let healthKitAvailable = HKHealthStore.isHealthDataAvailable()
    
    var body: some View {
        Section {
            ListParam("Health data", param: healthKitAvailable ? "Available" : "Unavailable")
        }
    }
}

#Preview {
    HealthKit()
}
