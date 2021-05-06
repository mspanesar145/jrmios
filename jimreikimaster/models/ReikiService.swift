//
//  ReikiService.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 21/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation

class ReikiService {
    
    var serviceId: Int32!;
    var title: String!;
    var description: String!;
    var fees: Int32!;
    var isActive: Bool!;

    func loadFromNSDictionary(reikiServiceDict: NSDictionary) -> ReikiService{
        let reikiService = populateReikiObject(reikiServiceDict: reikiServiceDict);
        return reikiService;
    }
    
    func loadFromNSArray(reikiServiceArr: NSArray) -> [ReikiService] {
        
        var reikiServices = [ReikiService]();
        for reikiServiceTmp in reikiServiceArr {
            let reikiServiceDict = reikiServiceTmp as! NSDictionary;
            reikiServices.append(loadFromNSDictionary(reikiServiceDict: reikiServiceDict));
        }
        return reikiServices;
    }
    
    func populateReikiObject(reikiServiceDict: NSDictionary) -> ReikiService {
        
        let reikiService = ReikiService();
        reikiService.serviceId = Int32(reikiServiceDict.value(forKey: "id") as! String);
        reikiService.title = reikiServiceDict.value(forKey: "title") as! String;
        reikiService.description = reikiServiceDict.value(forKey: "description") as! String;
        
        if let fees = reikiServiceDict.value(forKey: "fees") as? String {
            reikiService.fees = Int32(fees);
        }
        reikiService.isActive = Bool(reikiServiceDict.value(forKey: "is_active") as! String);

        return reikiService;
    }
}
