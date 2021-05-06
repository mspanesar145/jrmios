//
//  Notificaton.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 18/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation

class Notification {
    
    var notificationId: Int32!;
    var title: String!;
    var message: String!;
    var createdAt: Int64!;
    var readStatus: String!;
    
    func loadNotificationDict(notificationDict: NSDictionary) -> Notification {
        
        let notification = Notification();
        notification.notificationId = notificationDict.value(forKey: "notification_id") as! Int32;
        notification.title = notificationDict.value(forKey: "title") as! String;
        notification.message = notificationDict.value(forKey: "message") as! String;
        notification.readStatus = notificationDict.value(forKey: "read_status") as! String;
        notification.createdAt = notificationDict.value(forKey: "created_at") as! Int64;
        return notification;
    }
    
    func loadNotificationNSArray(notificationArr: NSArray) -> [Notification] {
     
        var notifications = [Notification]();
        for notificationItem in notificationArr {
            let notificationDict = notificationItem as! NSDictionary;
            notifications.append(loadNotificationDict(notificationDict: notificationDict));
        }
        return notifications;
    }
}
