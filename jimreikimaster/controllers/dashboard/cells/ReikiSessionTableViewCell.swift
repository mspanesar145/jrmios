//
//  ReikiSessionTableViewCell.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 14/02/2021.
//  Copyright © 2021 Cenes_Dev. All rights reserved.
//

import UIKit
import DropDown //1

class ReikiSessionTableViewCell: UITableViewCell {

    @IBOutlet weak var twentyMinutesView: UIView!;
    @IBOutlet weak var fortyFiveMinutesView: UIView!;
    @IBOutlet weak var oneHourView: UIView!;
    @IBOutlet weak var numberOfDaysView: UIView!;

    @IBOutlet weak var twentyMinutesLabel: UILabel!;
    @IBOutlet weak var fortyFiveMinutesLabel: UILabel!;
    @IBOutlet weak var oneHourLabel: UILabel!;
    @IBOutlet weak var numberOfDaysLabel: UILabel!;
    @IBOutlet weak var numberOfDaysGuide: UILabel!;
    @IBOutlet weak var chargesLabel: UILabel!;

    var reikiSessionDelegate: ReikiSessionViewController!;
    

    var dropDown = DropDown();
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.twentyMinutesView.dropGradientShadow();
        self.twentyMinutesView.layer.cornerRadius = 30;
        self.fortyFiveMinutesView.dropGradientShadow();
        self.fortyFiveMinutesView.layer.cornerRadius = 30;
        self.oneHourView.dropGradientShadow();
        self.oneHourView.layer.cornerRadius = 30;

        self.numberOfDaysView.dropGradientShadow();
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}


