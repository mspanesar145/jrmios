//
//  TransactionTableViewCell.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 14/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var outerShadowView: UIView!;
    
    @IBOutlet weak var titleLbl: UILabel!;
    @IBOutlet weak var priceLebl: UILabel!;
    @IBOutlet weak var dateBooked: UILabel!;
    @IBOutlet weak var timeSlotBooked: UILabel!;

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outerShadowView.layer.masksToBounds = false
        outerShadowView.layer.shadowColor = UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 1).cgColor
        outerShadowView.layer.shadowOpacity = 0.2
        outerShadowView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        outerShadowView.layer.shadowRadius = 4
        outerShadowView.layer.shouldRasterize = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
