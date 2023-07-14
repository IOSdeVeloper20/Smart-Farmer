//
//  NotificationManager.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 08/06/2023.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    // Define the shared instance of the NotificationManager
    static let shared = NotificationManager()
    
    // Override the init method to set up the delegate
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    // Request authorization for notifications
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                // User granted permission
            } else {
                // User denied permission or there was an error
            }
        }
    }
    
    // Schedule a local notification
    func scheduleNotification(title: String, body: String, interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        
        var component = DateComponents()
        component.calendar = Calendar.current
        component.weekday = 1
        component.hour = 20
        component.minute = 0
        
        //This trigger to get the notification after specific time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        
        // This trigger to get the notification at a specific time
        //let triggerAtSpecificTime = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("There was an error scheduling the notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    // Handle notification actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
