//
//  CountryItemTableViewCell.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 18/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class CountryItemTableViewCell: UITableViewCell {

    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var countryItemSeparator: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
