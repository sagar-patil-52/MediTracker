//
//  TodayViewModel.swift
//  MediTracker
//
//  Created by mmt on 16/07/21.
//

import Foundation

protocol MedicineScheduleDelegate: AnyObject {
    func didTakeMedicine(time: String, hasTaken: Bool)
}

struct TodayViewModel {
    
    var today: DailyDose?
    weak var delegate: MedicineScheduleDelegate?

    init() {
        let localDataHandler = LocalStorageHandler()
        if let todaysDose = localDataHandler.fetchDataForToday() {
            today = todaysDose
        }
    }
    
    func getScore() -> Int {
        today?.score ?? 0
    }
    
    mutating func getGreetingMessage() -> String {
        return Constants.Strings.greeting.replacingOccurrences(of: Constants.Strings.messagePlaceholder, with: Utils.message())
    }
    
    mutating func medicineTaken() {
        //For the first time medicine taken for a day object will be nil
        if today == nil {
            today = DailyDose(context: PersistenceService.context)
            today?.date = Date()
        }
        timeWhenMedicineTaken()
        PersistenceService.saveContext()
    }
    
    mutating func timeWhenMedicineTaken() {
        var hasTaken = true
        var time = ""
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6...11 :
            self.today?.morning = Date()
            time = Constants.Strings.morning
        case 12...17 :
            today?.afternoon = Date()
            time = Constants.Strings.afternoon
        case 18...23 :
            today?.evening = Date()
            time = Constants.Strings.evening
        default:
            //odd timing show appropriate alert
            hasTaken = false
        }
        delegate?.didTakeMedicine(time: time, hasTaken: hasTaken)
    }
}
