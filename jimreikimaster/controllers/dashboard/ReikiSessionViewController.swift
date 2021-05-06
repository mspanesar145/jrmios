//
//  ReikiSessionViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 14/02/2021.
//  Copyright © 2021 Cenes_Dev. All rights reserved.
//

import UIKit

class ReikiSessionViewController: UIViewController {

    @IBOutlet weak var reikiSessionTableView: UITableView!;
    @IBOutlet weak var nxtButton: UIButton!;
    
    var sessionIntervals = [String]();
    var sessionIntervalValueMap = [String: String]();
    var duration: Int = 1;
    var charges: Int = 100;
    var durationInterval: String = "Day";
    var sessionDurationInMinutes: Int = 20;

    var reikiSessionTableViewCellDelegate: ReikiSessionTableViewCell!;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.reikiSessionTableView.register(UINib.init(nibName: "ReikiSessionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ReikiSessionTableViewCell");
        
        self.sessionIntervals = ["1 Day", "2 Days", "3 Days", "4 Days", "5 Days", "6 Days", "1 Week", "2 Weeks", "3 Weeks", "1 Month"];
        
        self.sessionIntervalValueMap = [String: String]();
        self.sessionIntervalValueMap["1 Day"] = "1";
        self.sessionIntervalValueMap["2 Days"] = "2";
        self.sessionIntervalValueMap["3 Days"] = "3";
        self.sessionIntervalValueMap["4 Days"] = "4";
        self.sessionIntervalValueMap["5 Days"] = "5";
        self.sessionIntervalValueMap["6 Days"] = "6";
        self.sessionIntervalValueMap["1 Week"] = "1";
        self.sessionIntervalValueMap["2 Weeks"] = "2";
        self.sessionIntervalValueMap["3 Weeks"] = "3";
        self.sessionIntervalValueMap["1 Month"] = "1";
        
        self.tabBarController?.tabBar.isHidden = true;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        let longTitleLabel = UILabel()
        longTitleLabel.text = "REIKI SESSION"
        longTitleLabel.textColor = UIColor.white;
        let leftItem = UIBarButtonItem(customView: longTitleLabel)
        //self.navigationItem.leftBarButtonItem = leftItem
        let leftItemBackImageView = UIButton();
        leftItemBackImageView.frame = CGRect.init(x: 10, y: (self.navigationController?.navigationBar.frame.height)!/2, width: 20, height: 20);
        leftItemBackImageView.setImage(UIImage.init(named: "iv_back_icon"), for: .normal)
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(backButtonPressed));
        leftItemBackImageView.addGestureRecognizer(tapGestureRecognizer);
        
        let leftItemBack = UIBarButtonItem(customView: leftItemBackImageView)
        self.navigationItem.leftBarButtonItems = [leftItemBack, leftItem];
        self.tabBarController?.tabBar.isHidden = true;
    }
    
    @IBAction func nextButtonPressed(sender: UIButton) {
        
        currentTransaction.reikiSession = ReikiSession();
        if (self.durationInterval == "Day") {
            currentTransaction.reikiSession.sessionDays = self.duration;
        } else if (self.durationInterval == "Week") {
            currentTransaction.reikiSession.sessionDays = self.duration*7;
        } else if (self.durationInterval == "Month") {
            currentTransaction.reikiSession.sessionDays = self.duration*30;
        }
        currentTransaction.reikiSession.sessionInterval = self.sessionDurationInMinutes;
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "BookAppointmentDateViewController") as! BookAppointmentDateViewController;
        self.navigationController?.pushViewController(viewController, animated: true);
    }
    
    @objc func twentyMinutesPressed(sender: SessionTapGesture) {
        
        sender.cellRessionCell.twentyMinutesView.backgroundColor = JrmColor.purpleColor;
        sender.cellRessionCell.fortyFiveMinutesView.backgroundColor = UIColor.white;
        sender.cellRessionCell.oneHourView.backgroundColor = UIColor.white;
        
        sender.cellRessionCell.twentyMinutesLabel.textColor = UIColor.white;
        sender.cellRessionCell.fortyFiveMinutesLabel.textColor = UIColor.black;
        sender.cellRessionCell.oneHourLabel.textColor = UIColor.black;
        self.charges = 100;
        self.sessionDurationInMinutes = 20;

        var durationIntervalValue = 0;
        if (self.durationInterval == "Day") {
           durationIntervalValue = 1;
        } else if (self.durationInterval == "Week") {
           durationIntervalValue = 7;
        } else if (self.durationInterval == "Month") {
           durationIntervalValue = 30;
        }
         
        if (self.reikiSessionTableViewCellDelegate != nil) {
            if (self.durationInterval == "Day") {
               self.reikiSessionTableViewCellDelegate.numberOfDaysGuide.text = "Number Of Days";
            } else if (self.durationInterval == "Week") {
               self.reikiSessionTableViewCellDelegate.numberOfDaysGuide.text = "Number Of Weeks";
            } else if (self.durationInterval == "Month") {
               self.reikiSessionTableViewCellDelegate.numberOfDaysGuide.text = "Number Of Months";
            }

            self.reikiSessionTableViewCellDelegate.chargesLabel.text = "$\(100*durationIntervalValue*self.duration)";
        }
    }
    
    @objc func fortyFiveMinutesPressed(sender: SessionTapGesture) {
        sender.cellRessionCell.twentyMinutesView.backgroundColor = UIColor.white;
        sender.cellRessionCell.fortyFiveMinutesView.backgroundColor = JrmColor.purpleColor;
        sender.cellRessionCell.oneHourView.backgroundColor = UIColor.white;
        
        sender.cellRessionCell.fortyFiveMinutesLabel.textColor = UIColor.white;
        sender.cellRessionCell.twentyMinutesLabel.textColor = UIColor.black;
        sender.cellRessionCell.oneHourLabel.textColor = UIColor.black;
        
        self.charges = 130;
        self.sessionDurationInMinutes = 45;

        var durationIntervalValue = 0;
        if (self.durationInterval == "Day") {
           durationIntervalValue = 1;
        } else if (self.durationInterval == "Week") {
           durationIntervalValue = 7;
        } else if (self.durationInterval == "Month") {
           durationIntervalValue = 30;
        }
        var plurar = "";
        if (self.duration > 1) {
            plurar = "s";
        }
        if (self.reikiSessionTableViewCellDelegate != nil) {
            if (self.durationInterval == "Day") {
               self.reikiSessionTableViewCellDelegate.numberOfDaysGuide.text = "Number Of Days";
            } else if (self.durationInterval == "Week") {
               self.reikiSessionTableViewCellDelegate.numberOfDaysGuide.text = "Number Of Weeks";
            } else if (self.durationInterval == "Month") {
               self.reikiSessionTableViewCellDelegate.numberOfDaysGuide.text = "Number Of Months";
            }
            self.reikiSessionTableViewCellDelegate.chargesLabel.text = "$\(self.charges*durationIntervalValue*self.duration)";
        }
    }
    
    @objc func oneHourPressed(sender: SessionTapGesture) {
        sender.cellRessionCell.twentyMinutesView.backgroundColor = UIColor.white;
        sender.cellRessionCell.fortyFiveMinutesView.backgroundColor = UIColor.white;
        sender.cellRessionCell.oneHourView.backgroundColor = JrmColor.purpleColor;
        
        sender.cellRessionCell.fortyFiveMinutesLabel.textColor = UIColor.black;
        sender.cellRessionCell.twentyMinutesLabel.textColor = UIColor.black;
        sender.cellRessionCell.oneHourLabel.textColor = UIColor.white;
        
        self.charges = 150;
        self.sessionDurationInMinutes = 60;

        var durationIntervalValue = 0;
        if (self.durationInterval == "Day") {
            durationIntervalValue = 1;
        } else if (self.durationInterval == "Week") {
            durationIntervalValue = 7;
        } else if (self.durationInterval == "Month") {
            durationIntervalValue = 30;
        }
        var plurar = "";
        if (self.duration > 1) {
            plurar = "s";
        }
        if (self.reikiSessionTableViewCellDelegate != nil) {
            if (self.durationInterval == "Day") {
               self.reikiSessionTableViewCellDelegate.numberOfDaysGuide.text = "Number Of Days";
            } else if (self.durationInterval == "Week") {
               self.reikiSessionTableViewCellDelegate.numberOfDaysGuide.text = "Number Of Weeks";
            } else if (self.durationInterval == "Month") {
               self.reikiSessionTableViewCellDelegate.numberOfDaysGuide.text = "Number Of Months";
            }
            self.reikiSessionTableViewCellDelegate.chargesLabel.text = "$\(self.charges*durationIntervalValue*self.duration)";
        }
    }
    
    @objc func numberOfDaysPressed(sender: SessionIntervalTapGesture) {
        
        sender.cellRessionCell.dropDown.dataSource = self.sessionIntervals//4
        
        sender.cellRessionCell.dropDown.bottomOffset = CGPoint(x: 0, y: sender.cellRessionCell.numberOfDaysView.frame.size.height) //6
        sender.cellRessionCell.dropDown.anchorView = sender.cellRessionCell.numberOfDaysView;
        sender.cellRessionCell.dropDown.show();//7
        sender.cellRessionCell.dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
          guard let _ = self else { return }
            
            sender.intervalLabel.text = sender.sessionIntervalValueMap[item];
            sender.duration = Int(sender.sessionIntervalValueMap[item]!);
            self?.duration = sender.duration;
            if (item.contains("Day")) {
                self!.durationInterval = "Day";
                sender.numberOfDaysGuide.text = "Number Of Days";
                sender.chargesLabel.text = "$\(100*sender.duration)";
                
            } else if (item.contains("Week")) {
                
                self!.durationInterval = "Week";
                sender.numberOfDaysGuide.text = "Number Of Weeks";
                sender.chargesLabel.text = "$\(130*7*sender.duration)";

            } else if (item.contains("Month")) {
                
                self!.durationInterval = "Month";
                sender.numberOfDaysGuide.text = "Number Of Months";
                sender.chargesLabel.text = "$\(150*30*sender.duration)";
            }
        }

    }
}

class SessionTapGesture : UITapGestureRecognizer {
    var type: String!;
    var cellRessionCell: ReikiSessionTableViewCell!;
}

class SessionIntervalTapGesture : UITapGestureRecognizer {
    var intervalLabel: UILabel!;
    var chargesLabel: UILabel!;
    var numberOfDaysGuide: UILabel!;
    var sessionIntervalValueMap: [String: String]!;
    var duration: Int!;
    var charges: Int!;
    var cellRessionCell: ReikiSessionTableViewCell!;
}


extension ReikiSessionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReikiSessionTableViewCell") as! ReikiSessionTableViewCell;
        cell.reikiSessionDelegate = self;
        
        let twentyTapGesture = SessionTapGesture.init(target: self, action: #selector(twentyMinutesPressed(sender:)));
        twentyTapGesture.type = "TwentyMinutes";
        twentyTapGesture.cellRessionCell = cell;
        cell.twentyMinutesView.addGestureRecognizer(twentyTapGesture);
        
        let fortyFiveTapGesture = SessionTapGesture.init(target: self, action: #selector(fortyFiveMinutesPressed(sender:)));
        twentyTapGesture.type = "FortyFiveMinutes";
        fortyFiveTapGesture.cellRessionCell = cell;
        cell.fortyFiveMinutesView.addGestureRecognizer(fortyFiveTapGesture);
        
        let OneHourTapGesture = SessionTapGesture.init(target: self, action: #selector(oneHourPressed(sender:)));
        OneHourTapGesture.type = "OneHour";
        OneHourTapGesture.cellRessionCell = cell;
        cell.oneHourView.addGestureRecognizer(OneHourTapGesture);
        
        cell.twentyMinutesView.backgroundColor = JrmColor.purpleColor;
        cell.fortyFiveMinutesView.backgroundColor = UIColor.white;
        cell.oneHourView.backgroundColor = UIColor.white;
        
        cell.twentyMinutesLabel.textColor = UIColor.white;
        cell.fortyFiveMinutesLabel.textColor = UIColor.black;
        cell.oneHourLabel.textColor = UIColor.black;
        
        let numberOfDaysGesture = SessionIntervalTapGesture.init(target: self, action: #selector(numberOfDaysPressed));
        numberOfDaysGesture.sessionIntervalValueMap = self.sessionIntervalValueMap;
        numberOfDaysGesture.intervalLabel = cell.numberOfDaysLabel;
        numberOfDaysGesture.numberOfDaysGuide = cell.numberOfDaysGuide;
        numberOfDaysGesture.chargesLabel = cell.chargesLabel;
        numberOfDaysGesture.charges = self.charges;
        numberOfDaysGesture.cellRessionCell = cell;
        cell.numberOfDaysView.addGestureRecognizer(numberOfDaysGesture);
        
        self.reikiSessionTableViewCellDelegate = cell;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 672;
    }
}
