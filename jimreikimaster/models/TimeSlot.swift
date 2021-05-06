//
//  TimeSlot.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 09/02/2021.
//  Copyright © 2021 Cenes_Dev. All rights reserved.
//

import Foundation

class TimeSlot {
    
    var timeSlotId: Int32!;
    var startTime: Int64!;
    var endTime: Int64!;
    var timeSlotDate: Int64!;
    var timeSlotDateStr: String!;
    var timeSlotStatusId: Int!;
    var bookings: Int!;

    func loadFromNSDictionary(nsDict: NSDictionary) -> TimeSlot {
        
        let timeSlot = TimeSlot();
        timeSlot.timeSlotId = Int32(nsDict.value(forKey: "time_slot_id") as! String);
        timeSlot.startTime = Int64(nsDict.value(forKey: "start_time") as! String);
        timeSlot.endTime = Int64(nsDict.value(forKey: "end_time") as! String);
        timeSlot.timeSlotDate = Int64(nsDict.value(forKey: "time_slot_date") as! String);
        timeSlot.timeSlotDateStr = nsDict.value(forKey: "time_slot_date_str") as! String;
        timeSlot.timeSlotStatusId = Int(nsDict.value(forKey: "time_slot_status_id") as! String);
        timeSlot.bookings = Int(nsDict.value(forKey: "bookings") as! String);
        return timeSlot;
        
    }
    
    func loadFromNSArray(nsArr: NSArray) -> [TimeSlot] {
        
        var timeSlots = [TimeSlot]();
        
        for nsArrItem in nsArr {
            let nsArrItemDict =  nsArrItem as! NSDictionary;
            timeSlots.append(loadFromNSDictionary(nsDict: nsArrItemDict));
        }
        
        return timeSlots;
    }
}
