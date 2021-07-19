//
//  NotificationViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 14/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var notificationTableView: UITableView!;
    
    var allnotifications = [Notification]();
    var loggedInUser = User();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        notificationTableView.register(UINib.init(nibName: "NotificationTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "NotificationTableViewCell");
        
        
        self.loggedInUser = dbHelper.findLoggedInUser();
        self.makeAllNotificationsCall();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let longTitleLabel = UILabel()
        longTitleLabel.text = "NOTIFICATIONS"
        longTitleLabel.textColor = UIColor.white;
        let leftItem = UIBarButtonItem(customView: longTitleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let flareGradientImage = CAGradientLayer.primaryGradient(on: navigationController!.navigationBar)
        self.navigationController!.navigationBar.setBackgroundImage(flareGradientImage, for: UIBarMetrics.default)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func makeAllNotificationsCall() {
        
        var postData = [String: Any]();
        postData["userId"] = self.loggedInUser.userId;
        postData["offset"] = 0;
        postData["limit"] = 20;

        HttpService().makePostRequest(apiUrl: HomeAPI.post_user_notifications_request, postData: postData, complete: {response in
            
            let success = response.value(forKey: APIResponseEnum.STATUS) as! String;
            if (success == APIResponseEnum.SUCCESS) {
                
                let notificationsArr = response.value(forKey: APIResponseEnum.DATA) as! NSArray;
                self.allnotifications = Notification().loadNotificationNSArray(notificationArr:  notificationsArr);
                self.notificationTableView.reloadData();
            }
        });
    }

}


extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allnotifications.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let notification = self.allnotifications[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell;
        
        cell.notificationTitle.text = notification.title;
        cell.notificationMessage.text = notification.message;
        
        let nowDate = Date()
        let notificationTime = Date(timeIntervalSince1970: Double(notification.createdAt/1000));

        let diff = Int(nowDate.timeIntervalSince1970 - notificationTime.timeIntervalSince1970)

        let days = (diff / 2600) / 24;
        let hours = diff / 3600
        let minutes = (diff - hours * 3600) / 60
        let seconds = ((diff - hours * 3600) / 60)/60;
        if (days != 0) {
            if (days > 6) {
                cell.notificationTime.text = "\(days/7) week ago";
            } else {
                cell.notificationTime.text = "\(days) days ago";
            }
        } else if (hours != 0) {
            cell.notificationTime.text = "\(hours) hours ago";
        } else if (minutes != 0) {
            cell.notificationTime.text = "\(minutes) minutes ago";
        } else if (seconds != 0) {
            cell.notificationTime.text = "\(seconds) seconds ago";
        }
        return cell;
    }
}
