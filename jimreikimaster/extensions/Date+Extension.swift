//
//  Date+Extension.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 27/02/2021.
//  Copyright © 2021 Cenes_Dev. All rights reserved.
//

import Foundation

extension Date {
    
    func hhssa(millisecond: Int64) -> String {

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a";

        return dateFormatterPrint.string(from: dateFromMillis(millisecond: millisecond));
    }
    
    func dateFromMillis(millisecond: Int64) -> Date {
        return Date(timeIntervalSince1970: TimeInterval.init(exactly: millisecond/1000)!);
    }
}
