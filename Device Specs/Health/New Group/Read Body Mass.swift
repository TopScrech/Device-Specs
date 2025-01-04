//import HealthyKit
//
//extension HealthVM {
//    func readBodyMass() {
//        guard let bodyMassType else {
//            return
//        }
//        
//        // from 1 month ago to now
//        let endDate = Date()
//        let startDate = Calendar.current.date(
//            byAdding: .month,
//            value: -12,
//            to: Date()
//        )
//        
//        let predicate = HKQuery.predicateForSamples(
//            withStart: startDate,
//            end:       endDate,
//            options:   .strictStartDate
//        )
//        
//        let sortDescriptor = NSSortDescriptor(
//            key: HKSampleSortIdentifierStartDate,
//            ascending: false
//        )
//        
//        let query = HKSampleQuery(
//            sampleType: bodyMassType,
//            predicate: predicate,
//            limit: HKObjectQueryNoLimit,
//            sortDescriptors: [sortDescriptor]
//            
//        ) { query, results, error in
//            
//            if let error {
//                print("Error retrieving body mass data: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let samples = results as? [HKQuantitySample] else {
//                print("Could not fetch body mass samples")
//                return
//            }
//            
//            var records: [HealthRecord] = []
//            
//            for sample in samples {
//                let value = sample.quantity.doubleValue(for: .kilogram())
//                
//                records.append(.init(
//                    value:  value,
//                    date:   sample.startDate,
//                    sample: sample
//                ))
//                
//                DispatchQueue.main.async { [self] in
//                    bodyMass = records
//                }
//            }
//        }
//        
//        store.execute(query)
//    }
//}
