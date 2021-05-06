//
//  DbHelper+UserExtension.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 29/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation
import SQLite3
extension DBHelper {
    
    func createTableUsers() {
        let createTableString = "CREATE TABLE IF NOT EXISTS users(user_id INTEGER PRIMARY KEY,name TEXT, email TEXT, photo TEXT, phone TEXT, phone_code TEXT, customer_id TEXT, address TEXT);"
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("user table created.")
            } else {
                print("user table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
        
    func saveUser(user: User) {
        let insertStatementString = "INSERT INTO users (user_id, name, email, photo, phone, phone_code, customer_id, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"

        var insertStatement: OpaquePointer?
          // 1
          if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
              SQLITE_OK {
            let id: Int64 = user.userId
            let name: NSString = user.name as! NSString
            let email: NSString = user.email as! NSString
            let photo: NSString = user.photo as! NSString
            let phone: NSString = user.phone as! NSString
            let phoneCode: NSString = user.phoneCode as! NSString
            let customerId: NSString = user.customerId as! NSString;
            let address: NSString = user.address as! NSString;

            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, email.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, photo.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, phone.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, phoneCode.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, customerId.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, address.utf8String, -1, nil)

            // 4
            if sqlite3_step(insertStatement) == SQLITE_DONE {
              print("\nSuccessfully inserted row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(insertStatement))
                print("\nCould not insert row. \(errmsg)")
            }
          } else {
            print("\nINSERT statement is not prepared.")
          }
          // 5
          sqlite3_finalize(insertStatement)
    }
    
    func findUserByType(type: String) -> [User] {
        
        var users = [User]();
        let queryStatementString = "SELECT * FROM users where type = ?"

          var queryStatement: OpaquePointer?
          // 1
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            
            sqlite3_bind_text(queryStatement, 1, type, -1, nil);
            // 2
            if sqlite3_step(queryStatement) == SQLITE_ROW {
              // 3
                /*let user = User();
                user.userId = Int64(sqlite3_column_int(queryStatement, 0));
                user.name = String(cString: sqlite3_column_text(queryStatement, 1));
                user.email = String(cString: sqlite3_column_text(queryStatement, 2));
                user.photo = String(cString: sqlite3_column_text(queryStatement, 3));
                user.phone = String(cString: sqlite3_column_text(queryStatement, 4));
                user.type = String(cString: sqlite3_column_text(queryStatement, 5));*/
                users.append(populateUserModel(queryStatement: queryStatement!));
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
        return users;
    }

    func findLoggedInUser() -> User {
        
        var user = User();
        
        let queryStatementString = "SELECT * FROM users;";

          var queryStatement: OpaquePointer?
          // 1
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            // 2
            if sqlite3_step(queryStatement) == SQLITE_ROW {
              // 3
                user = populateUserModel(queryStatement: queryStatement!);
              // 4
          } else {
              print("\nQuery returned no results.")
          }
          } else {
              // 6
            let errorMessage = String(cString: sqlite3_errmsg(queryStatement))
            print("\nQuery is not prepared \(errorMessage)")
          }
          // 7
        sqlite3_finalize(queryStatement);
        return user;
    }
    
    func updateUserCustomerIdAndAddress(userId: Int64, customerId: String, address: String) {
        
        let updateStatementString = "update users set customer_id = '\(customerId)', address = '\(address)' where user_id = \(userId)";
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)

    }
    
    func populateUserModel(queryStatement: OpaquePointer) ->User {
        
        let user = User();
        user.userId = Int64(sqlite3_column_int(queryStatement, 0));
        user.name = String(cString: sqlite3_column_text(queryStatement, 1));
        user.email = String(cString: sqlite3_column_text(queryStatement, 2));
        user.photo = String(cString: sqlite3_column_text(queryStatement, 3));
        user.phone = String(cString: sqlite3_column_text(queryStatement, 4));
        user.phoneCode = String(cString: sqlite3_column_text(queryStatement, 5));
        user.customerId = String(cString: sqlite3_column_text(queryStatement, 6));
        user.address = String(cString: sqlite3_column_text(queryStatement, 7));

        return user;
    }
}
