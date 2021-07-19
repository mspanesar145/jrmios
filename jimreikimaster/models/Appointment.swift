//
//  Appointment.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 29/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation
 
class Appointment {
    
    var appointmentId: Int64 = 0;
    var appontmentDate: Int64 = 0;
    var startTime: Int64 = 0;
    var endTime: Int64 = 0;
    var bookenOn: Int64 = 0;
    var durationInDays: Int = 0;
    var fees: Int = 0;
    var title: String = "";
    
    func loadFromNSDictionary(appointmentDict: NSDictionary) -> Appointment{
        
        let appointment = Appointment();
        
        appointment.title = appointmentDict.value(forKey: "title") as! String;
        appointment.startTime = Int64(appointmentDict.value(forKey: "start_time") as! String)!;
        appointment.endTime = Int64(appointmentDict.value(forKey: "end_time") as! String)!;
        appointment.bookenOn = Int64(appointmentDict.value(forKey: "booked_on") as! String)!;
        if let fees = appointmentDict.value(forKey: "fees") as? String {
            appointment.fees = Int(fees)!;
        } else {
            appointment.fees = 0;
        }
        
        return appointment;
        
    }
    func loadFromNSArray(appointmentsArr: NSArray) -> [Appointment]{
        
        var appointments = [Appointment]();
        for appointmentsArrItem in appointmentsArr {
            let appointmentsArrItemDict = appointmentsArrItem as! NSDictionary;
            let appointment = loadFromNSDictionary(appointmentDict: appointmentsArrItemDict);
            appointments.append(appointment);
        }
        return appointments;
    }
}
