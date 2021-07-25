//
//  HistoryViewModel.swift
//  MediTracker
//
//  Created by mmt on 16/07/21.
//

import Foundation


struct HistoryViewModel {
    
    var history = [DailyDose]()
    
    mutating func getHistory() {
        
        //Uncomment below line to add test data.
//        testData()
        
        let localDataHandler = LocalStorageHandler()
        let historyArr = localDataHandler.fetchData()
        if historyArr.count > 0 {
            history.removeAll()
            history.append(contentsOf: historyArr)
        }
    }
    
    func getErrorMessage() -> String {
        if history.count > 0 {
            return ""
        } else {
            return Constants.Error.noHistory
        }
    }
    
    //This is a test data.. call this function to add data with all possible values for testing purpose. Currently created all objects with same date later add check to insert/update only one object same date
    func testData() {
                
        for _ in 0...1 {
            let today = DailyDose(context: PersistenceService.context)
            today.morning = Date()
            today.afternoon = Date()
            today.evening = Date()
            today.date = Date()
            PersistenceService.saveContext()
        }
        
        for _ in 0..<1 {
            let today = DailyDose(context: PersistenceService.context)
            today.morning = Date()
            today.date = Date()
            PersistenceService.saveContext()
        }
        
        for _ in 0..<1 {
            let today = DailyDose(context: PersistenceService.context)
            today.afternoon = Date()
            today.evening = Date()
            today.date = Date()
            PersistenceService.saveContext()
        }
        
        for _ in 0..<1 {
            let today = DailyDose(context: PersistenceService.context)
            today.date = Date()
            PersistenceService.saveContext()
        }
        
        for _ in 0..<1 {
            let today = DailyDose(context: PersistenceService.context)
            today.evening = Date()
            today.date = Date()
            PersistenceService.saveContext()
        }
        
        for _ in 0...1 {
            let today = DailyDose(context: PersistenceService.context)
            today.morning = Date()
            today.afternoon = Date()
            today.evening = Date()
            today.date = Date()
            PersistenceService.saveContext()
        }
    }
}
