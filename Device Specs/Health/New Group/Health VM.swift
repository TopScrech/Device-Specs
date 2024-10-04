import HealthKit

@Observable
final class HealthVM {
    let store = HKHealthStore()
    var glucoseUnit = HKUnit(from: "mg/dl") /// mmol/L unavailible
    
    // TODO: Add workouts
    
    //    static func activeEnergyBurned() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .activeEnergyBurned)
    //    }
    //
    //    static func basalEnergyBurned() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .basalEnergyBurned)
    //    }
    //
    //    static func bloodAlcoholContent() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .bloodAlcoholContent)
    //    }
    //
    //    static func bloodGlucose() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .bloodGlucose)
    //    }
    //
    //    static func bloodPressureDiastolic() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .bloodPressureDiastolic)
    //    }
    //
    //    static func bloodPressureSystolic() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .bloodPressureSystolic)
    //    }
    
    //    static func dietaryBiotin() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryBiotin)
    //    }
    //
    //    static func dietaryCaffeine() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryCaffeine)
    //    }
    //
    //    static func dietaryCalcium() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryCalcium)
    //    }
    //
    //    static func dietaryCarbohydrates() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryCarbohydrates)
    //    }
    //
    //    static func dietaryChloride() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryChloride)
    //    }
    //
    //    static func dietaryCholesterol() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryCholesterol)
    //    }
    //
    //    static func dietaryChromium() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryChromium)
    //    }
    //
    //    static func dietaryCopper() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryCopper)
    //    }
    //
    //    static func dietaryEnergyConsumed() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryEnergyConsumed)
    //    }
    //
    //    static func dietaryFatMonounsaturated() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryFatMonounsaturated)
    //    }
    //
    //    static func dietaryFatPolyunsaturated() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryFatPolyunsaturated)
    //    }
    //
    //    static func dietaryFatSaturated() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryFatSaturated)
    //    }
    //
    //    static func dietaryFatTotal() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryFatTotal)
    //    }
    //
    //    static func dietaryFiber() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryFiber)
    //    }
    //
    //    static func dietaryFolate() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryFolate)
    //    }
    //
    //    static func dietaryIodine() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryIodine)
    //    }
    //
    //    static func dietaryIron() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryIron)
    //    }
    //
    //    static func dietaryMagnesium() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryMagnesium)
    //    }
    //
    //    static func dietaryManganese() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryManganese)
    //    }
    //
    //    static func dietaryMolybdenum() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryMolybdenum)
    //    }
    //
    //    static func dietaryNiacin() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryNiacin)
    //    }
    //
    //    static func dietaryPantothenicAcid() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryPantothenicAcid)
    //    }
    //
    //    static func dietaryPhosphorus() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryPhosphorus)
    //    }
    //
    //    static func dietaryPotassium() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryPotassium)
    //    }
    //
    //    static func dietaryProtein() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryProtein)
    //    }
    //
    //    static func dietaryRiboflavin() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryRiboflavin)
    //    }
    //
    //    static func dietarySelenium() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietarySelenium)
    //    }
    //
    //    static func dietarySodium() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietarySodium)
    //    }
    //
    //    static func dietarySugar() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietarySugar)
    //    }
    //
    //    static func dietaryThiamin() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryThiamin)
    //    }
    //
    //    static func dietaryVitaminA() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryVitaminA)
    //    }
    //
    //    static func dietaryVitaminB6() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryVitaminB6)
    //    }
    //
    //    static func dietaryVitaminB12() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryVitaminB12)
    //    }
    //
    //    static func dietaryVitaminD() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryVitaminD)
    //    }
    //
    //    static func dietaryVitaminE() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryVitaminE)
    //    }
    //
    //    static func dietaryVitaminK() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryVitaminK)
    //    }
    //
    //    static func dietaryZinc() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryZinc)
    //    }
    //
    //    static func distanceCycling() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .distanceCycling)
    //    }
    //
    //    static func distanceWalkingRunning() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .distanceWalkingRunning)
    //    }
    
    //    static func flightsClimbed() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .flightsClimbed)
    //    }
    //
    //    static func forcedExpiratoryVolume1() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .forcedExpiratoryVolume1)
    //    }
    //
    //    static func forcedVitalCapacity() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .forcedVitalCapacity)
    //    }
    //
    //    static func heartRate() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .heartRate)
    //    }
    
    //    static func inhalerUsage() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .inhalerUsage)
    //    }
    
    
    //    static func nikeFuel() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .nikeFuel)
    //    }
    //
    //    static func numberOfTimesFallen() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .numberOfTimesFallen)
    //    }
    //
    //    static func oxygenSaturation() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .oxygenSaturation)
    //    }
    //
    //    static func peakExpiratoryFlowRate() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .peakExpiratoryFlowRate)
    //    }
    //
    //    static func peripheralPerfusionIndex() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .peripheralPerfusionIndex)
    //    }
    //
    //    static func respiratoryRate() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .respiratoryRate)
    //    }
    //
    //    static func stepCount() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .stepCount)
    //    }
    
    //    static func dietaryWater() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .dietaryWater)
    //    }
    //
    //    static func uvExposure() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .uvExposure)
    //    }
    //
    //    static func appleExerciseTime() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .appleExerciseTime)
    //    }
    //
    //    static func distanceSwimming() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .distanceSwimming)
    //    }
    //
    //    static func distanceWheelchair() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .distanceWheelchair)
    //    }
    //
    //    static func pushCount() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .pushCount)
    //    }
    //
    //    static func swimmingStrokeCount() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .swimmingStrokeCount)
    //    }
    //    static func heartRateVariabilitySDNN() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .heartRateVariabilitySDNN)
    //    }
    //
    //    static func insulinDelivery() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .insulinDelivery)
    //    }
    //
    //    static func restingHeartRate() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .restingHeartRate)
    //    }
    
    //    static func walkingHeartRateAverage() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .walkingHeartRateAverage)
    //    }
    //
    //    static func distanceDownhillSnowSports() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .distanceDownhillSnowSports)
    //    }
    //
    //    static func appleStandTime() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .appleStandTime)
    //    }
    //
    //    static func environmentalAudioExposure() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .environmentalAudioExposure)
    //    }
    //
    //    static func headphoneAudioExposure() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .headphoneAudioExposure)
    //    }
    //
    //    static func sixMinuteWalkTestDistance() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .sixMinuteWalkTestDistance)
    //    }
    //
    //    static func stairAscentSpeed() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .stairAscentSpeed)
    //    }
    //
    //    static func stairDescentSpeed() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .stairDescentSpeed)
    //    }
    //
    //    static func walkingAsymmetryPercentage() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .walkingAsymmetryPercentage)
    //    }
    //
    //    static func walkingDoubleSupportPercentage() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .walkingDoubleSupportPercentage)
    //    }
    //
    //    static func walkingSpeed() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .walkingSpeed)
    //    }
    //
    //    static func walkingStepLength() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .walkingStepLength)
    //    }
    //    static func appleMoveTime() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .appleMoveTime)
    //    }
    //
    //    static func appleWalkingSteadiness() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .appleWalkingSteadiness)
    //    }
    //
    //    static func numberOfAlcoholicBeverages() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .numberOfAlcoholicBeverages)
    //    }
    
    //    static func atrialFibrillationBurden() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .atrialFibrillationBurden)
    //    }
    //
    //    static func environmentalSoundReduction() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .environmentalSoundReduction)
    //    }
    //
    //    static func runningGroundContactTime() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .runningGroundContactTime)
    //    }
    //
    //    static func runningPower() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .runningPower)
    //    }
    //
    //    static func runningSpeed() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .runningSpeed)
    //    }
    //
    //    static func runningStrideLength() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .runningStrideLength)
    //    }
    //
    //    static func runningVerticalOscillation() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .runningVerticalOscillation)
    //    }
    //
    //    static func underwaterDepth() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .underwaterDepth)
    //    }
    //
    //    static func waterTemperature() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .waterTemperature)
    //    }
    //
    //    static func cyclingCadence() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .cyclingCadence)
    //    }
    //
    //    static func cyclingFunctionalThresholdPower() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .cyclingFunctionalThresholdPower)
    //    }
    //
    //    static func cyclingPower() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .cyclingPower)
    //    }
    //
    //    static func cyclingSpeed() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .cyclingSpeed)
    //    }
    //
    //    static func physicalEffort() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .physicalEffort)
    //    }
    //
    //    static func timeInDaylight() -> HKQuantityType? {
    //        self.quantityType(forIdentifier: .timeInDaylight)
    //    }
    
    init() {
        if isAvailable {
            authorize { result in
                if result {
                    print("Suc")
                } else {
                    print("Suck")
                }
            }
        } else {
            print("HealthKit is unavailable")
        }
    }
    
    // Body Measurements
    // Add Vision Prescription
    
    // sleepingWristTemperatureType unavailible to share (read)
    // let sleepingWristTemperatureType: HKQuantityType? = .appleSleepingWristTemperature()
    let bodyMassType:              HKQuantityType? = .bodyMass()
    let waistCircumferenceType:    HKQuantityType? = .waistCircumference()
    let basalBodyTemperatureType:  HKQuantityType? = .basalBodyTemperature()
    let leanBodyMassType:          HKQuantityType? = .leanBodyMass()
    let heightType:                HKQuantityType? = .height()
    let electrodermalActivityType: HKQuantityType? = .electrodermalActivity()
    let bodyFatPercentageType:     HKQuantityType? = .bodyFatPercentage()
    let bmiType:                   HKQuantityType? = .bodyMassIndex()
    let bodyTemperatureType:       HKQuantityType? = .bodyTemperature()
    
    var bodyMass: [BodyMass] = []
    
    var isAvailable: Bool {
        HKHealthStore.isHealthDataAvailable()
    }
    
    private var dataTypes: Set<HKQuantityType> {
        guard
            let bodyMassType,
            let waistCircumferenceType,
            let basalBodyTemperatureType,
            let leanBodyMassType,
            let heightType,
            let electrodermalActivityType,
            let bodyFatPercentageType,
            let bmiType,
            let bodyTemperatureType
        else {
            return []
        }
        
        return Set([
            bodyMassType,
            waistCircumferenceType,
            basalBodyTemperatureType,
            leanBodyMassType,
            heightType,
            electrodermalActivityType,
            bodyFatPercentageType,
            bmiType,
            bodyTemperatureType
        ])
    }
    
    //    var isAuthorized: Bool {
    //        guard let glucoseType else {
    //            return false
    //        }
    //
    //        return store?.authorizationStatus(for: glucoseType) == .sharingAuthorized
    //    }
    
    func authorize(_ handler: @escaping (Bool) -> Void) {
        store.requestPermission(dataTypes) { success, error in
            guard let error else {
                return handler(success)
            }
            
            print(error.localizedDescription)
            handler(false)
        }
    }
    
    func getAuthorizationState(_ handler: @escaping (Bool) -> Void) {
        store.getRequestStatusForPermission(dataTypes) { status, error in
            guard let error else {
                return handler(status == .unnecessary)
            }
            
            print(error.localizedDescription)
            handler(false)
        }
    }
}
