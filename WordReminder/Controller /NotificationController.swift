//
//  NotificationController.swift
//  WordReminder
//
//  Created by Burak on 29.07.2021.
//

import Foundation
import UIKit

class NotificationController {
    
    static let shared = NotificationController()
    
    func scheduleNotification(){

        if Constants.savedWordsArray.count > 0 {
            let content = UNMutableNotificationContent()
            content.title = "Here is one of your last recorded translations".localizeString()
            content.sound = .default
            let random = Int.random(in: 0..<Constants.savedWordsArray.count)
            content.body = "'\(Constants.savedWordsArray[random].word1)' = '\(Constants.savedWordsArray[random].word2)'"
            
            var dateComponents = DateComponents()
            let defaults = UserDefaults.standard
            let hour = defaults.object(forKey: "hour") as? String ?? "17"
            let minute = defaults.object(forKey: "minute") as? String ?? "00"
            dateComponents.hour = Int(hour)
            dateComponents.minute = Int(minute)

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let notification = UNNotificationRequest(identifier: "savedID", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(notification, withCompletionHandler: nil)
        }

    }
    
    private init () {
        
    }
    
}
