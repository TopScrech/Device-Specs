import HealthKit

struct HealthRecord: Identifiable {
    let id = UUID()
    
    var value: Double
    var date: Date
    var sample: HKQuantitySample?
}
