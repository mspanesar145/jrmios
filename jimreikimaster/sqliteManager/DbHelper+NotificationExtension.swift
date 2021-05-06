//
//  DbHelper+NotificationExtension.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 18/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation
import SQLite3

extension DBHelper {

    func createTableNotifications() {
        let createTableString = "CREATE TABLE IF NOT EXISTS notiifications(notification_id INTEGER PRIMARY KEY,title TEXT, message TEXT, read_status TEXT, created_at INTEGER);"
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("NOTOFICATION CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func saveNotification(notification: Notification) {
        let insertStatementString = "INSERT INTO notifications (notification_id, title, message, read_status, created_at) VALUES (?, ?, ?, ?, ?);"

        var insertStatement: OpaquePointer?
          // 1
          if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
              SQLITE_OK {
            let id: Int32 = notification.notificationId
            let title: String = notification.title
            let message: String = notification.message
            let readStatus: String = notification.readStatus
            let createdAt: Int64 = notification.createdAt

            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, title, -1, nil)
            sqlite3_bind_text(insertStatement, 3, message, -1, nil)
            sqlite3_bind_text(insertStatement, 4, readStatus, -1, nil)
            sqlite3_bind_int(insertStatement, Int32(createdAt), -1)

            // 4
            if sqlite3_step(insertStatement) == SQLITE_DONE {
              print("\nSuccessfully inserted row.")
            } else {
              print("\nCould not insert row.")
            }
          } else {
            print("\nINSERT statement is not prepared.")
          }
          // 5
          sqlite3_finalize(insertStatement)
    }
    
    func findAllNotifications() -> [Notification] {
        
        var notifications = [Notification]();
        let queryStatementString = "SELECT * FROM notifications"

          var queryStatement: OpaquePointer?
          // 1
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            // 2
            if sqlite3_step(queryStatement) == SQLITE_ROW {
              // 3
                notifications.append(populateNotification(queryStatement: queryStatement!));
              // 4
          } else {
              print("\nQuery returned no results.")
          }
          } else {
              // 6
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          // 7
        sqlite3_finalize(queryStatement);
        return notifications;
    }
    
    func findNotificationByNotificationId(notificationId: Int32) -> Notification {
        
        var notification = Notification();
        let queryStatementString = "SELECT * FROM notifications where notiification_id = ?"

          var queryStatement: OpaquePointer?
          // 1
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            
            sqlite3_bind_int(queryStatement, 1, notificationId);
            // 2
            if sqlite3_step(queryStatement) == SQLITE_ROW {
              // 3
                notification = populateNotification(queryStatement: queryStatement!);
              // 4
          } else {
              print("\nQuery returned no results.")
          }
          } else {
              // 6
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          // 7
        sqlite3_finalize(queryStatement);
        return notification;
    }

    func populateNotification(queryStatement: OpaquePointer) -> Notification{
        let notification = Notification();
        notification.notificationId = Int32(sqlite3_column_int(queryStatement, 0));
        notification.title = String(cString: sqlite3_column_text(queryStatement, 1));
        notification.message = String(cString: sqlite3_column_text(queryStatement, 2));
        notification.readStatus = String(cString: sqlite3_column_text(queryStatement, 3));
        notification.createdAt = Int64(sqlite3_column_int(queryStatement, 4));
        return notification;
    }
}
