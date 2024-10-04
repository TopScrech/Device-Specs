//import HealthyKit
//
//extension HealthKit {
//    func readCarbs() {
//        guard let carbsType else {
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
//            sampleType: carbsType,
//            predicate: predicate,
//            limit: HKObjectQueryNoLimit,
//            sortDescriptors: [sortDescriptor]
//            
//        ) { query, results, error in
//            
//            if let error {
//                print("Error retrieving insulin delivery data: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let samples = results as? [HKQuantitySample] else {
//                print("Could not fetch insulin delivery samples")
//                return
//            }
//            
//            var records: [Carbohydrates] = []
//            
//            for sample in samples {
//                let value = sample.quantity.doubleValue(for: .gram())
//                
//                records.append(.init(
//                    value:  Int(value),
//                    date:   sample.startDate,
//                    sample: sample
//                ))
//                
//                DispatchQueue.main.async { [self] in
//                    main.history.carbs = records
//                }
//            }
//        }
//        
//        store?.execute(query)
//    }
//}
