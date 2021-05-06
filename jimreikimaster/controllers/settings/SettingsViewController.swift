//
//  SettingsViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 13/02/2021.
//  Copyright © 2021 Cenes_Dev. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!;
    @IBOutlet weak var denchionSolBtn: UIButton!;

    var settingsItemArr: [String]!;
    var settingsItemIconArr: [String]!;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingsTableView.register(UINib.init(nibName: "SettingsItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SettingsItemTableViewCell");
    
        self.settingsItemArr = ["My Account", "Contact Us", "Feedback", "Technical Support", "Logout"];
        self.settingsItemIconArr = ["myaccount", "contact_us", "feedback", "technical_support", "logout"];

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
        
        self.tabBarController?.tabBar.isHidden = true;

        let longTitleLabel = UILabel()
        longTitleLabel.text = "SETTINGS"
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
    
    @IBAction func denchionBtnPressed(sender: UIButton) {
        guard let instagram = URL(string: JrmConstants.technicalSupportWeblink) else { return }
        UIApplication.shared.open(instagram)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsItemArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsItemTableViewCell", for: indexPath) as! SettingsItemTableViewCell;
        
        cell.itemLabel.text = self.settingsItemArr[indexPath.row];
        cell.itemIcon.image = UIImage.init(named: settingsItemIconArr[indexPath.row]);

        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0) {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController;
            self.navigationController?.pushViewController(viewController, animated: true);
        } else if (indexPath.row == 1) {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController;
            self.navigationController?.pushViewController(viewController, animated: true);
        } else if (indexPath.row == 2) {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController;
            self.navigationController?.pushViewController(viewController, animated: true);
        } else if (indexPath.row == 3) {
           let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TechnicalSupportViewController") as! TechnicalSupportViewController;
           self.navigationController?.pushViewController(viewController, animated: true);
        } else if (indexPath.row == 4) {
            
            let refreshAlert = UIAlertController(title: "Logout!", message: "Are you sure?", preferredStyle: UIAlertController.Style.alert)

            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                  print("Handle Ok logic here")
                
                
            }))

            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
            }))

            present(refreshAlert, animated: true, completion: nil)
        }
    }
}
