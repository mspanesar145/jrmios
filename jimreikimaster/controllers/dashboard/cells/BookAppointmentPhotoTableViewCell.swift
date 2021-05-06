//
//  BookAppointmentPhotoTableViewCell.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 25/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class BookAppointmentPhotoTableViewCell: UITableViewCell, BookAppointmentPhotoTableViewCellProtocol {

    @IBOutlet weak var firstInnerCircleView: UIView!;
    @IBOutlet weak var secondOuterCircleView: UIView!;
    @IBOutlet weak var secondInnerCirleView: UIView!;
    @IBOutlet weak var thirdInnerCircleView: UIView!;
    @IBOutlet weak var uploadPhotoContainerView: UIView!;
    @IBOutlet weak var uploadPhotoBrowseBtn: UIImageView!;
    @IBOutlet weak var userFullImage: UIImageView!;

    var bookAppointmentPhotoDelegate: BookAppointmentPhotoViewController!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.firstInnerCircleView.circleView();
        self.secondOuterCircleView.circleViewWithBorder();
        self.secondInnerCirleView.circleView();
        self.thirdInnerCircleView.circleView();
        self.uploadPhotoContainerView.layer.cornerRadius = 22;
        self.uploadPhotoContainerView.layer.borderWidth = 1;
        self.uploadPhotoContainerView.layer.borderColor = UIColor.systemPurple.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func uploadImageAndGetUrl(imageToUpload: UIImage) {
        self.userFullImage.isHidden = false;
        self.userFullImage.image = imageToUpload;
        self.uploadPhotoContainerView.isHidden = true;
        self.uploadPhotoBrowseBtn.isHidden = true;
    }
    
}
