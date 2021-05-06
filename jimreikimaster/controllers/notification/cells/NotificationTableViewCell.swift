//
//  NotificationTableViewCell.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 14/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationViewContainer: UIView!;
    @IBOutlet weak var appointmentTypeIcon: UIImageView!;
    @IBOutlet weak var notificationTitle: UILabel!;
    @IBOutlet weak var notificationMessage: UILabel!;
    @IBOutlet weak var notificationTime: UILabel!;

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        notificationViewContainer.layer.masksToBounds = false
        notificationViewContainer.layer.shadowColor = UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 1).cgColor
        notificationViewContainer.layer.shadowOpacity = 0.2
        notificationViewContainer.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        notificationViewContainer.layer.shadowRadius = 4
        notificationViewContainer.layer.shouldRasterize = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
