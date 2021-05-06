//
//  BookAppointmentPaymentOptionTableViewCell.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 03/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class BookAppointmentPaymentOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var firstInnerCircleView: UIView!;
    @IBOutlet weak var secondInnerCirleView: UIView!;
    @IBOutlet weak var thirdInnerCircleView: UIView!;
    @IBOutlet weak var thirdOuterCircleView: UIView!;
    @IBOutlet weak var creditCardCheckboxView: UIView!;
    @IBOutlet weak var creditCardCheckboxImage: UIImageView!;
    @IBOutlet weak var paypalCheckboxView: UIView!;
    @IBOutlet weak var paypalCheckboxImage: UIImageView!;
    @IBOutlet weak var addCardButton: UIButton!;

    var bookAppointmentPaymentOptionDelegate: BookAppointmentPaymentOptionsViewController!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.firstInnerCircleView.circleView();
        self.secondInnerCirleView.circleView();
        self.thirdInnerCircleView.circleView();
        self.thirdOuterCircleView.circleViewWithBorder();
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func addCardPressed() {
        //self.bookAppointmentPaymentOptionDelegate.paymentContext.pushPaymentOptionsViewController();
        
        self.bookAppointmentPaymentOptionDelegate.paymentContext.pushShippingViewController();
    }
}
