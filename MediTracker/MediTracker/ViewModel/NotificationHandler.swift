//
//  NotificationHandler.swift
//  MediTracker
//
//  Created by mmt on 23/07/21.
//

import Foundation
import UserNotifications

class NotificationHandler {
    
    func requestAuthorisationForLocalNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] success, error in
            if success {
                print("All set!")
                self?.setDailyNotifications()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func setDailyNotifications() {
        setNotification(notificationID: Constants.Strings.morning, hours: Constants.MedicineAlertTime.morning, mins: 0)
        setNotification(notificationID: Constants.Strings.afternoon, hours: Constants.MedicineAlertTime.afternoon, mins: 0)
        setNotification(notificationID: Constants.Strings.evening, hours: Constants.MedicineAlertTime.evening, mins: 0)
    }
    
    func setNotification(notificationID : String, hours : Int, mins : Int) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = Constants.Strings.notificationTitle
        notificationContent.body = Constants.Strings.notificationMessage
        notificationContent.sound = .default
        
        var datComp = DateComponents()
        datComp.hour = hours
        datComp.minute = mins
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
        let request = UNNotificationRequest(identifier: notificationID, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
    
    func cancelNotifications(notificationID : String) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [notificationID])
    }
}
