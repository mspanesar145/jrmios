//
//  HomeViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 22/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    class func MainViewController() -> UITabBarController {
        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainTab") as! UITabBarController
        return tabBarController
    }
    
    @IBOutlet weak var homeTableView: UITableView!;
    var reikiServices: [ReikiService]!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        homeTableView.register(UINib.init(nibName: "ServiceTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ServiceTableViewCell");
        
        homeTableView.layer.masksToBounds = false
        homeTableView.layer.shadowColor = UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 0.3).cgColor
        homeTableView.layer.shadowOpacity = 0.2
        homeTableView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        homeTableView.layer.shadowRadius = 5
        homeTableView.layer.shouldRasterize = true
        
        let colors = [UIColor.init(red: 255/255, green: 101/255, blue: 139/255, alpha: 1), UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 1)];
        self.navigationController?.navigationBar.setGradientBackground(colors: colors);
       
        loggedInUser = dbHelper.findLoggedInUser();
        self.reikiServices = [ReikiService]();
        self.makeAllServicesCall();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let colors = [UIColor.init(red: 255/255, green: 101/255, blue: 139/255, alpha: 1), UIColor.init(red: 150/255, green: 114/255, blue: 251/255, alpha: 1)];
        self.navigationController?.navigationBar.setGradientBackground(colors: colors);
        
        self.tabBarController?.tabBar.isHidden = false;
        
        let longTitleLabel = UILabel()
        longTitleLabel.text = "DASHBOARD"
        longTitleLabel.textColor = UIColor.white;
        let leftItem = UIBarButtonItem(customView: longTitleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let profileIcon = UIImageView()
        profileIcon.image = UIImage.init(named: "menu_icon");
        profileIcon.isUserInteractionEnabled = true;
        let rightItem = UIBarButtonItem(customView: profileIcon)
        self.navigationItem.rightBarButtonItem = rightItem
        
        let menuTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(menuButtonPressed))
        profileIcon.addGestureRecognizer(menuTapGesture);
        
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
    
    func makeAllServicesCall() {
        HttpService().makeGetRequest(apiUrl: HomeAPI.get_reiki_services, complete: {response in
            
            let success = response.value(forKey: APIResponseEnum.STATUS) as! String;
            if (success == APIResponseEnum.SUCCESS) {
                
                let servicesArr = response.value(forKey: APIResponseEnum.DATA) as! NSArray;
                self.reikiServices = ReikiService().loadFromNSArray(reikiServiceArr: servicesArr);
                self.homeTableView.reloadData();
            }
        });
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reikiServices.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reikiService = self.reikiServices[indexPath.row];

        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell") as! ServiceTableViewCell;
        cell.serviceTitle.text = reikiService.title!;
        if (indexPath.row == 0) {
            cell.serviceImage.image = UIImage.init(named: "flower_crown");
        } else if (indexPath.row == 1) {
            cell.serviceImage.image = UIImage.init(named: "flower_third_eye");
        } else if (indexPath.row == 2) {
            cell.serviceImage.image = UIImage.init(named: "flower_throat");
        } else if (indexPath.row == 3) {
            cell.serviceImage.image = UIImage.init(named: "flower_heart");
        } else if (indexPath.row == 4) {
            cell.serviceImage.image = UIImage.init(named: "flower_solar_plex");
        } else if (indexPath.row == 5) {
           cell.serviceImage.image = UIImage.init(named: "flower_sacral");
        } else if (indexPath.row == 6) {
          cell.serviceImage.image = UIImage.init(named: "flower_root");
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let reikiService = self.reikiServices[indexPath.row];
        
        currentTransaction.reikiService = reikiService;
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ReikiSessionViewController") as! ReikiSessionViewController;
        self.navigationController?.pushViewController(viewController, animated: true);
    
    }
}
