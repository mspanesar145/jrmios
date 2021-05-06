//
//  User.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 29/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation

class User {
    
    var userId: Int64 = 0;
    var name: String = "";
    var email: String = "";
    var address: String = "";
    var phone: String = "";
    var phoneCode: String = "";
    var photo: String = "";
    var type: String = "";
    var password: String = "";
    var facebookId: String = "";
    var status: Int8 = 1;
    var customerId: String = "";

    func loadUserFromNSDict(userDict: NSDictionary) -> User {
        let user = User();
        user.userId = Int64(userDict.value(forKey: "id") as! String)!;
        user.name = userDict.value(forKey: "fullname") as! String;
        user.email = userDict.value(forKey: "email") as! String;
        if let phoneCode = userDict.value(forKey: "countryCode") as? String {
            user.phoneCode = phoneCode;
        }
        if let phone = userDict.value(forKey: "phoneNumber") as? String {
            user.phone = phone;
        }
        if let photo = userDict.value(forKey: "photo") as? String {
            user.photo = photo;
        }
        
        if let type = userDict.value(forKey: "type") as? String {
            user.type = type;
        }
        
        if let fbId = userDict.value(forKey: "facebookId") as? String {
            user.facebookId = fbId;
        }
        
        if let customerId = userDict.value(forKey: "customerId") as? String {
            user.customerId = customerId;
        }
        
        if let address = userDict.value(forKey: "address") as? String {
            user.address = address;
        }
        
        user.status = Int8(userDict.value(forKey: "status") as! String)!;
        return user;
    }
    
    func toDictionary(user: User) -> [String: Any] {
        
        var postDict = [String: Any]();
        postDict["id"] = user.userId;
        postDict["fullname"] = user.name;
        postDict["email"] = user.email;
        postDict["phoneNumber"] = user.phone;
        postDict["countryCode"] = user.phone;
        postDict["password"] = user.password;
        postDict["photo"] = user.photo;
        postDict["type"] = user.type;
        postDict["facebookId"] = user.facebookId;
        postDict["customerId"] = user.customerId;
        postDict["status"] = user.status;
        postDict["address"] = user.address;

        return postDict;
        
    }
}
