//
//  DailyDose+CoreDataProperties.swift
//  MediTracker
//
//  Created by mmt on 19/07/21.
//
//

import Foundation
import CoreData


extension DailyDose {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyDose> {
        return NSFetchRequest<DailyDose>(entityName: Constants.Strings.dailyDose)
    }

    @NSManaged public var morning: Date?
    @NSManaged public var afternoon: Date?
    @NSManaged public var evening: Date?
    @NSManaged public var date: Date?

}

extension DailyDose : Identifiable {

}

extension DailyDose {
    
    var score : Int {
        var score = 0
        if let _ = self.morning  { score += Constants.Points.morning  }
        if let _ = self.afternoon { score += Constants.Points.afternoon }
        if let _ = self.evening { score += Constants.Points.evening }
        return score
    }
}
