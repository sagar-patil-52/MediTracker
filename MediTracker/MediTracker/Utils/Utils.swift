//
//  Utils.swift
//  MediTracker
//
//  Created by mmt on 17/07/21.
//

import Foundation


final class Utils {

    static func message() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6...11 :
            return Constants.Strings.morning
        case 12...17 :
            return Constants.Strings.afternoon
        case 18...23 :
            return Constants.Strings.evening
        default: return ""
        }
    }
    
    static func getTime(date: Date) -> String {
        
        let hour = Calendar.current.component(.hour, from: date)
        let mins = Calendar.current.component(.minute, from: date)
        let time = String(format: "%02d:%02d", hour, mins)
        return time
    }
    
    static func formatDate(date: Date) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "E, d MMM yyyy"
        return dateformat.string(from: date)
    }
}
