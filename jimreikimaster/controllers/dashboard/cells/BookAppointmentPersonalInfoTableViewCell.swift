//
//  BookAppointmentPersonalInfoTableViewCell.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 13/02/2021.
//  Copyright © 2021 Cenes_Dev. All rights reserved.
//

import UIKit

class BookAppointmentPersonalInfoTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var firstInnerCircleView: UIView!;
    @IBOutlet weak var secondOuterCircleView: UIView!;
    @IBOutlet weak var secondInnerCirleView: UIView!;
    @IBOutlet weak var thirdInnerCircleView: UIView!;

    @IBOutlet weak var nameTextFieldView: UIView!;
    @IBOutlet weak var genderLabelViewView: UIView!;
    @IBOutlet weak var addressTextFieldView: UIView!;
    @IBOutlet weak var descriptionTextFieldView: UIView!;

    @IBOutlet weak var nameTextField: UITextField!;
    @IBOutlet weak var genderLabel: UILabel!;
    @IBOutlet weak var addressTextField: UITextField!;
    @IBOutlet weak var descriptionTextField: UITextField!;

    var bookAppointmentPersonalInfoDelegate : BookAppointmentPersonalInfoViewController!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.firstInnerCircleView.circleView();
        self.secondOuterCircleView.circleViewWithBorder();
        self.secondInnerCirleView.circleView();
        self.thirdInnerCircleView.circleView();

        nameTextFieldView.rounderCornerViewWithBorder();
        genderLabelViewView.rounderCornerViewWithBorder();
        addressTextFieldView.curvedCornerViewWithBorder();
        descriptionTextFieldView.curvedCornerViewWithBorder();

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
