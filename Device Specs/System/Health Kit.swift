import ScrechKit
import HealthKit

struct HealthKit: View {
    private let healthKitAvailable = HKHealthStore.isHealthDataAvailable()
    
    var body: some View {
        Section {
            ListParam("Health data available", param: healthKitAvailable ? "Yes" : "No")
        }
    }
}

#Preview {
    HealthKit()
}
