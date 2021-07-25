//
//  LocalStorageHandler.swift
//  MediTracker
//
//  Created by mmt on 19/07/21.
//

import Foundation
import CoreData

class LocalStorageHandler  {
        
    func storeData<T>( entity : T) {
        
        let entityName = String(describing: T.self)
        NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                            into: PersistenceService.context)
    }
    
    func fetchDataForToday() -> DailyDose? {
        
        let startOfDay = Date().startOfDay
        let datePredicate = NSPredicate(format: "date < %@  AND date > %@" , Date() as NSDate, startOfDay as NSDate)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Strings.dailyDose)
        request.predicate = datePredicate
        request.returnsObjectsAsFaults = false
        do {
            let result = try PersistenceService.context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let dose = data as? DailyDose {
                   return dose
                }
            }
        } catch {
            print(Constants.Error.dataFetchError)
        }
        return nil
    }
    
    func fetchData() -> [DailyDose] {
        var history = [DailyDose]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Strings.dailyDose)
        request.returnsObjectsAsFaults = false
        do {
            let result = try PersistenceService.context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let dose = data as? DailyDose {
                    history.append(dose)
                }
            }
        } catch {
            print(Constants.Error.dataFetchError)
        }
        return history
    }
}

