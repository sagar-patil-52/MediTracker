//
//  Constants.swift
//  MediTracker
//
//  Created by mmt on 20/07/21.
//

import Foundation
import UIKit

struct Constants {
    struct TableConfig {
        static let rowHeight : CGFloat = 110
    }
    
    struct Colors {
        static let blueColor = UIColor.init(red: 80/255, green:140/255, blue: 160/255, alpha: 1)
        static let darkBlueColor = UIColor.init(red: 45/255, green:50/255, blue: 69/255, alpha: 1)
    }
    
    struct Points {
        static let morning = 30
        static let afternoon = 30
        static let evening = 40
    }
    
    struct MedicineAlertTime {
        static let morning = 11
        static let afternoon = 14
        static let evening = 20
    }
    
    struct Strings {
        static let dailyDose = "DailyDose"
        static let mediTracker = "MediTracker"
        static let morning = "Morning"
        static let afternoon = "Afternoon"
        static let evening = "Evening"
        static let greeting = "Good MessagePlaceholder \n\nToday's Score"
        static let messagePlaceholder = "MessagePlaceholder"
        static let ok = "OK"
        static let noMedicineTaken = "No medicine taken"
        static let notificationTitle = "It's time for your meds"
        static let notificationMessage = "Hey, please take your meds to stay happy and healthy."
    }
    
    struct Error {
        static let dataFetchError = "Failed to fetch data from core data"
        static let invalidMedicineTimeErrorTitle = "Oops"
        static let invalidMedicineTimeErrorMessage = "Take a nap!"
        static let noHistory = "When you take your medicines, your history will appear here."
    }
    
    struct Identifiers {
        static let main = "Main"
        static let historyVC = "HistoryViewController"
        static let dashboardVC = "DashboardViewController"
        static let historyTableViewCell = "HistoryTableViewCell"
    }
}
