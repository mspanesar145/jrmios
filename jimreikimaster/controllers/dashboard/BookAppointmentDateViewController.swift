//
//  BookAppointmentDateViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 24/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

protocol BookAppointmentDateProtocol {
    func updateSelectedDate(selectedDate: Date);
}

class BookAppointmentDateViewController: UIViewController {

    @IBOutlet weak var bookingAppointmentTableView: UITableView!
    @IBOutlet weak var appointmentDatePicker: UIDatePicker!;
    @IBOutlet weak var nextBtn: UIButton!;
    @IBOutlet weak var cancelBtn: UIButton!;
    @IBOutlet weak var doneBtn: UIButton!;
    @IBOutlet weak var datePickerContainerView: UIView!;

    var bookAppointmentDateProtocolDelegate: BookAppointmentDateProtocol!;
    var selectedDate: Int64!;
    var timeSlots: [TimeSlot]!;
    var timeSlotBubbles = [TimeSlotBubble]();
    var timeSlotBubbleIndexBoolMap = [Int: Bool]();
    var timeSlotBubbleIndexBubbleMap = [Int: TimeSlotBubble]();
    var selectedTimeslotBubble: TimeSlotBubble!;
    var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bookingAppointmentTableView.register(UINib.init(nibName: "BookAppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "BookAppointmentTableViewCell");
        
        self.selectedDate = Int64(Date().timeIntervalSince1970) * 1000;
        self.tabBarController?.tabBar.isHidden = true;
        self.appointmentDatePicker.minimumDate = Date();
        self.bookingAppointmentTableView.reloadData();
        
        self.fetchCurrentDateTimeSlots();
        
        self.loadingIndicator.isHidden = true;
        self.loadingIndicator.style = .medium;
        self.loadingIndicator.frame = CGRect.init(x: self.view.frame.width/2 - self.loadingIndicator.frame.width/2, y:  self.view.frame.height/2 - self.loadingIndicator.frame.height/2, width: self.loadingIndicator.frame.width, height: self.loadingIndicator.frame.height)
        self.view.addSubview(self.loadingIndicator);
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        let longTitleLabel = UILabel()
        longTitleLabel.text = "BOOK APPOINTMENT - 1"
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

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func showHideDatePicker() {
        
        if (self.datePickerContainerView.isHidden == true) {
            self.datePickerContainerView.isHidden = false;
            nextBtn.isHidden = true;
        } else {
            self.datePickerContainerView.isHidden = true;
            nextBtn.isHidden = false;
        }
    }
    
    func fetchCurrentDateTimeSlots() {
        
        self.loadingIndicator.isHidden = false;
        self.loadingIndicator.startAnimating();
        
        var startDateCompos = Calendar.current.dateComponents(in: TimeZone.current, from: Date(timeIntervalSince1970: (Double(self.selectedDate) / 1000.0)));
        startDateCompos.hour = 0;
        startDateCompos.minute = 0;
        startDateCompos.second = 0;
        startDateCompos.nanosecond = 0;
        let userStartTime = startDateCompos.date!.timeIntervalSince1970*1000;
        
        var endDateCompos = Calendar.current.dateComponents(in: TimeZone.current, from: Date(timeIntervalSince1970: (Double(self.selectedDate) / 1000.0)));
        endDateCompos.hour = 23;
        endDateCompos.minute = 59;
        endDateCompos.second = 59;
        endDateCompos.nanosecond = 0;
        let userEndTime = endDateCompos.date!.timeIntervalSince1970*1000;

        
        let apiEndpoint = "\(HomeAPI.get_timeslots_by_date)?userStartTime=\(userStartTime)&userEndTime=\(userEndTime)";
        
        HttpService().makeGetRequest(apiUrl: apiEndpoint, complete: {response in
            
            let success = response.value(forKey: APIResponseEnum.STATUS) as! String;
            if (success == APIResponseEnum.SUCCESS) {
            
                self.loadingIndicator.isHidden = true;
                self.loadingIndicator.stopAnimating();

                self.timeSlots = [TimeSlot]();
                self.timeSlotBubbles = [TimeSlotBubble]();
                self.timeSlotBubbleIndexBoolMap = [Int: Bool]();
                self.timeSlotBubbleIndexBubbleMap = [Int: TimeSlotBubble]();
                let timeslotArr = response.value(forKey: APIResponseEnum.DATA) as! NSArray;
                
                var currentTimeSlots = TimeSlot().loadFromNSArray(nsArr: timeslotArr);
                
                let currentDateComponent = Calendar.current.dateComponents(in: TimeZone.current, from: Date());
                
                var indx: Int = 0;
                for currentTimeSlot in currentTimeSlots {
                    
                    let timeSlotDate = Date(timeIntervalSince1970: (TimeInterval(currentTimeSlot.startTime) / 1000));
                    
                    print("timeSlotDate : ", timeSlotDate);
                    let timeSlotDateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: timeSlotDate);
                    
                    print("timeSlotDateComponents.day : ", timeSlotDateComponents.day, " currentDateComponent.day :  ",currentDateComponent.day);

                    //if (timeSlotDateComponents.day == currentDateComponent.day) {
                        self.timeSlots.append(currentTimeSlot);
                        
                        self.timeSlotBubbleIndexBoolMap[indx] = false;
                        indx = indx + 1;
                    //}
                }
                
                self.timeSlots.sort {$0.startTime < $1.startTime};
                self.bookingAppointmentTableView.reloadData();
            }
        });
    }
    
    @IBAction func nextBtnPressed(sender: UIButton) {
     
        if (self.selectedTimeslotBubble == nil) {
            showAlert(title: "Alert", message: "Please select the required time.");
            return;
        }
        
        currentTransaction.timeSlot = self.timeSlots[selectedTimeslotBubble.timeSlotPosition - 1];
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "BookAppointmentPersonalInfoViewController") as! BookAppointmentPersonalInfoViewController;
        self.navigationController?.pushViewController(viewController, animated: true);
    }
    
    @IBAction func cancelBtnPressed(sender: UIButton) {
     
        self.datePickerContainerView.isHidden = true;
        self.nextBtn.isHidden = false;
    }
    
    @IBAction func doneBtnPressed(sender: UIButton) {
     
        self.datePickerContainerView.isHidden = true;
        self.nextBtn.isHidden = false;
        self.bookAppointmentDateProtocolDelegate.updateSelectedDate(selectedDate: appointmentDatePicker.date);
        self.selectedDate = Int64(appointmentDatePicker.date.timeIntervalSince1970*1000);
        self.selectedTimeslotBubble = nil;
        self.fetchCurrentDateTimeSlots();
    }
    
    @objc func timeSlotBubblePressed(sender: TimeSlopBubbleGesture) {
        //let timeSlotBubble = sender.timeSlotBubble;
        
        if (self.selectedTimeslotBubble == nil) {
            self.selectedTimeslotBubble = sender.timeSlotBubble;
        } else {
            //self.selectedTimeslotBubble!.timeSlotBubbleView.backgroundColor = UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 0.1)
            
            //lets see if already selected bubble has same label or not.
            //print(self.selectedTimeslotBubble.timeSlotLabel.text, sender.timeSlotBubble.timeSlotLabel.text);
            if (self.selectedTimeslotBubble.timeSlotLabel.text! != sender.timeSlotBubble.timeSlotLabel.text!) {
                self.timeSlotBubbleIndexBoolMap[self.selectedTimeslotBubble.timeSlotPosition] = false;
                self.selectedTimeslotBubble = sender.timeSlotBubble;
            }
        }
        
        if (self.timeSlotBubbleIndexBoolMap[sender.timeSlotIndex] == true) {
            self.timeSlotBubbleIndexBoolMap[sender.timeSlotIndex] = false;
            //timeSlotBubble!.timeSlotBubbleView.backgroundColor = UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 0.1);
            
        } else {
            self.timeSlotBubbleIndexBoolMap[sender.timeSlotIndex] = true;
            //timeSlotBubble!.timeSlotBubbleView.backgroundColor = UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 1);
        }
        
        self.bookingAppointmentTableView.reloadData();
    }
}

extension BookAppointmentDateViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookAppointmentTableViewCell", for: indexPath) as! BookAppointmentTableViewCell;
        //cell.createTimeSlotBubbles();
        cell.bookAppointmentDateDelegate = self;
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MMM dd, yyyy"
        let resultString = inputFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(exactly: self.selectedDate/1000)!));

        cell.dateLabelView.text = resultString;
        
        self.bookAppointmentDateProtocolDelegate = cell;
        for subView in cell.timeSlotsContainerView.subviews {
            subView.removeFromSuperview();
        }
            
        var row: Int = 0;
        var col: Int = 0;
        
        if (self.timeSlots == nil) {
            return cell;
        }
        for i in 1..<(self.timeSlots.count + 1) {
            
            let timeSlotTmp = self.timeSlots[i - 1];
            
            let y = 40*row;
            let x = 110*col;

            let timeSlotBubble: TimeSlotBubble = TimeSlotBubble.instanceFromNib() as! TimeSlotBubble;
                
            timeSlotBubble.frame = CGRect.init(x: x, y: y, width: 100, height: 30);
            /*if (i < 13) {
                if (i == 12) {
                    timeSlotBubble.timeSlotLabel.text = "\(i-1)am - \(i)pm";
                } else if (i == 1) {
                    timeSlotBubble.timeSlotLabel.text = "00am - \(i)am";
                } else {
                    timeSlotBubble.timeSlotLabel.text = "\(i-1)am - \(i)am";
                }
            } else {
                if (i == 13) {
                    timeSlotBubble.timeSlotLabel.text = "\(i-1)pm - \(i+1 - 13)pm";
                } else if (i == 24) {
                    timeSlotBubble.timeSlotLabel.text = "\(i - 13)pm - 00am";
                } else {
                    timeSlotBubble.timeSlotLabel.text = "\(i - 13)pm - \(i+1 - 13)pm";
                }
            }*/
            
            timeSlotBubble.timeSlotLabel.textColor = UIColor.black;
            timeSlotBubble.timeSlotLabel.text = "\(Date().hhssa(millisecond: timeSlotTmp.startTime)) - \(Date().hhssa(millisecond: timeSlotTmp.endTime))"
            
            timeSlotBubble.timeSlotBubbleView.layer.cornerRadius = 15;
            if (timeSlotTmp.timeSlotStatusId == 1) {//Available
                timeSlotBubble.timeSlotBubbleView.backgroundColor = JrmColor.purpleColorUnselected;

            } else if (timeSlotTmp.timeSlotStatusId == 2) {//Booked
                timeSlotBubble.timeSlotBubbleView.backgroundColor = JrmColor.purpleColor;
            } else if (timeSlotTmp.timeSlotStatusId == 3) {//Blocked
                timeSlotBubble.timeSlotBubbleView.backgroundColor = UIColor.lightGray;
            }
            
            if (timeSlotTmp.timeSlotStatusId != 3) {
                let timeSlotGestureRecognizer = TimeSlopBubbleGesture.init(target: self, action: #selector(timeSlotBubblePressed(sender:)));
                timeSlotGestureRecognizer.tag = i;
                timeSlotGestureRecognizer.timeSlotIndex = i;
                timeSlotGestureRecognizer.timeSlotBubble = timeSlotBubble;
                timeSlotBubble.timeSlotBubbleView.addGestureRecognizer(timeSlotGestureRecognizer);
            }
            
            timeSlotBubble.timeSlotPosition = i;
            cell.timeSlotsContainerView.addSubview(timeSlotBubble);
            
            self.timeSlotBubbleIndexBubbleMap[i-1] = timeSlotBubble;
            
            col = col + 1;
            if (i%3 == 0) {
                row = row + 1;
                col = 0;
            }
            
            if (self.timeSlotBubbleIndexBoolMap[i] == true) {
                timeSlotBubble.timeSlotBubbleView.backgroundColor = UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 1);
                timeSlotBubble.timeSlotLabel.textColor = UIColor.white;
            }

        }
        cell.timeSlotsContainerView.frame = CGRect.init(x: cell.timeSlotsContainerView.frame.origin.x, y: cell.timeSlotsContainerView.frame.origin.y, width: cell.timeSlotsContainerView.frame.width, height: 300);
        return cell;
    }
}

class TimeSlopBubbleGesture: UITapGestureRecognizer {
    
    var timeSlotBubble: TimeSlotBubble!;
    var tag: Int!;
    var timeSlotIndex: Int!;

}
