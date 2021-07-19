//
//  TransactionViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 14/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    @IBOutlet weak var transactionTableView: UITableView!;
    
    var allAppointments = [Appointment]();
    var loggedInUser = User();
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        transactionTableView.register(UINib.init(nibName: "TransactionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TransactionTableViewCell");
        
        self.loggedInUser = dbHelper.findLoggedInUser();
        self.makeAllAppointmentsCall();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let longTitleLabel = UILabel()
        longTitleLabel.text = "TRANSACTIONS"
        longTitleLabel.textColor = UIColor.white;
        let leftItem = UIBarButtonItem(customView: longTitleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let flareGradientImage = CAGradientLayer.primaryGradient(on: navigationController!.navigationBar)
        self.navigationController!.navigationBar.setBackgroundImage(flareGradientImage, for: UIBarMetrics.default);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func makeAllAppointmentsCall() {
        
        var postData = [String: Any]();
        postData["userId"] = self.loggedInUser.userId;
        postData["offset"] = 0;
        postData["limit"] = 20;

        HttpService().makePostRequest(apiUrl: HomeAPI.get_user_appointments_request, postData: postData, complete: {response in
            
            let success = response.value(forKey: APIResponseEnum.STATUS) as! String;
            if (success == APIResponseEnum.SUCCESS) {
                
                let appointmentsArr = response.value(forKey: APIResponseEnum.DATA) as! NSArray;
                self.allAppointments = Appointment().loadFromNSArray(appointmentsArr: appointmentsArr);
                self.transactionTableView.reloadData();
            }
        });
    }
}

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAppointments.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let appointment = allAppointments[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell;
        
        cell.titleLbl.text = appointment.title;
        cell.priceLebl.text = "$\(appointment.fees)";
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        cell.dateBooked.text = dateFormatter.string(from: Date(timeIntervalSince1970: Double(appointment.bookenOn)/1000));
        
        let ampmFormatter = DateFormatter()
        ampmFormatter.dateFormat = "h:mm a"
        cell.timeSlotBooked.text = "\(ampmFormatter.string(from: Date(timeIntervalSince1970: Double(appointment.startTime)/1000))) - \(ampmFormatter.string(from: Date(timeIntervalSince1970: Double(appointment.endTime)/1000)))";
        return cell;
    }
}
