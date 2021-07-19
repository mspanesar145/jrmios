//
//  ServicePlan.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 26/06/2021.
//  Copyright © 2021 Cenes_Dev. All rights reserved.
//

import Foundation
class ServicePlan {
    
    var servicePlanId: Int32!;
    var name: String!;
    var duration: Int8!;
    var fees: Int32!;
    var serviceId: Int32!;
    var isActive: Bool!;

    func loadFromNSDictionary(servicePlanDict: NSDictionary) -> ServicePlan {
        let servicePlan = ServicePlan();
        servicePlan.servicePlanId = Int32(servicePlanDict.value(forKey: "service_plan_id") as! String)!;
        servicePlan.name = servicePlanDict.value(forKey: "name") as! String;
        servicePlan.duration = Int8(servicePlanDict.value(forKey: "duration") as! String)!;
        servicePlan.fees = Int32(servicePlanDict.value(forKey: "fees") as! String)!;
        servicePlan.serviceId = Int32(servicePlanDict.value(forKey: "service_id") as! String)!;
        let isActive = Int8(servicePlanDict.value(forKey: "is_active") as! String)!;
        if (isActive == 1) {
            servicePlan.isActive = true;
        } else {
            servicePlan.isActive = false;
        }
        return servicePlan;
    }
    
    func loadFromNSArray(servicePlanArr: NSArray) -> [ServicePlan] {
        
        var servicePlans = [ServicePlan]();
        for servicePlanTmp in servicePlanArr {
            let servicePlanDict = servicePlanTmp as! NSDictionary;
            servicePlans.append(loadFromNSDictionary(servicePlanDict: servicePlanDict));
        }
        return servicePlans;
    }
}
