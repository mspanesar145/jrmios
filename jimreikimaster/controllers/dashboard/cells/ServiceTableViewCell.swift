//
//  ServiceTableViewCell.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 22/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var flowerView: UIView!;
    @IBOutlet weak var serviceBubbleView: UIView!;
    @IBOutlet weak var serviceTitle: UILabel!;
    @IBOutlet weak var serviceImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        serviceBubbleView.layer.masksToBounds = false
        serviceBubbleView.layer.shadowColor = UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 1).cgColor
        serviceBubbleView.layer.shadowOpacity = 0.2
        serviceBubbleView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        serviceBubbleView.layer.shadowRadius = 4
        serviceBubbleView.layer.shouldRasterize = true
        
        flowerView.layer.masksToBounds = false
        flowerView.layer.shadowColor = UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 1).cgColor
        flowerView.layer.shadowOpacity = 0.2
        flowerView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        flowerView.layer.shadowRadius = 4
        flowerView.layer.shouldRasterize = true

        flowerView.layer.cornerRadius = 20;
        serviceBubbleView.layer.cornerRadius = 20;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
