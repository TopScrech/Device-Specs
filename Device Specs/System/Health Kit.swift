import ScrechKit

#if canImport(HealthKit)
import HealthKit
#endif

struct HealthKit: View {
    private var healthDataAvailable: Bool {
#if os(tvOS)
        false
#else
        HKHealthStore.isHealthDataAvailable()
#endif
    }
    
    private var supportsHealthRecords: Bool {
#if os(tvOS) || os(watchOS)
        false
#else
        HKHealthStore().supportsHealthRecords()
#endif
    }
    
    var body: some View {
        Section("Health") {
            ListParam("Health data", param: healthDataAvailable ? "Available" : "Unavailable")
            ListParam("Clinical records", param: supportsHealthRecords ? "Supported" : "Unsupported")
        }
    }
}

#Preview {
    HealthKit()
}
