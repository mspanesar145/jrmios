//
//  BookAppointmentTableViewCell.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 24/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class BookAppointmentTableViewCell: UITableViewCell, BookAppointmentDateProtocol {

    @IBOutlet weak var firstCircleOuterView: UIView!;
    @IBOutlet weak var firstCircleInnerView: UIView!;
    @IBOutlet weak var secondCircleInnerView: UIView!;
    @IBOutlet weak var thirdCircleInnerView: UIView!;
    @IBOutlet weak var datePlaceholderView: UIView!;
    @IBOutlet weak var dateLabelView: UILabel!;
    @IBOutlet weak var calendarImg: UIImageView!;
    @IBOutlet weak var timeSlotsContainerView: UIView!;

    var bookAppointmentDateDelegate: BookAppointmentDateViewController!;
    var timeSlotHolder: [Int: TimeSlotBubble] = [Int: TimeSlotBubble]();
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstCircleOuterView.circleViewWithBorder();
        firstCircleInnerView.circleView();
        secondCircleInnerView.circleView();
        thirdCircleInnerView.circleView();
        datePlaceholderView.rounderCornerViewWithBorder();
        
        let calendarImgTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(calendarImgPressed))
        datePlaceholderView.addGestureRecognizer(calendarImgTapGesture);
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateSelectedDate(selectedDate: Date) {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MMM dd, yyyy"
        let resultString = inputFormatter.string(from: selectedDate);
        self.dateLabelView.text = resultString;
    }
    
    @objc func calendarImgPressed() {
        self.bookAppointmentDateDelegate.showHideDatePicker();
    }
    
    
    @objc func onlyTapGesturePressed() {
        print("tapped");
    }
}

