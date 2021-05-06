//
//  TimeSlotBubble.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 22/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class TimeSlotBubble: UIView {

    @IBOutlet weak var timeSlotBubbleView: UIView!;
    @IBOutlet weak var timeSlotLabel: UILabel!;
    var timeSlotPosition: Int!;
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "TimeSlotBubble", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

}
