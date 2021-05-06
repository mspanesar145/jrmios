//
//  LoginViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 07/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    class func MainViewController() -> UINavigationController {
        
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginiNav") as! UINavigationController
        return navController
        
    }

    @IBOutlet weak var loginFormTableView: UITableView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true;
        loginFormTableView.register(UINib.init(nibName: "LoginFieldsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "LoginFieldsTableViewCell");
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     */
    func loginRequest(user: User) {
        
        var postData = [String: Any]();
        postData["email"] = user.email;
        postData["password"] = user.password;
        HttpService().makePostRequest(apiUrl: UserAPI.post_login_request, postData: postData, complete: {response in
            
            let success = response.value(forKey: APIResponseEnum.STATUS) as! String;
            if (success == APIResponseEnum.SUCCESS) {
                let userDict = response.value(forKey: APIResponseEnum.DATA) as! NSDictionary;
                let user = User().loadUserFromNSDict(userDict: userDict);
                dbHelper.saveUser(user: user);
                UIApplication.shared.keyWindow?.rootViewController = HomeViewController.MainViewController();
            } else {
                
                let message = response.value(forKey: APIResponseEnum.MESSAGE) as! String;
                self.showAlert(title: AlertTitleEnum.ALERT, message: message);
            }
        });
    }
}

extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 823;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoginFieldsTableViewCell", for: indexPath) as! LoginFieldsTableViewCell;
        cell.loginViewControllerDelegate = self;
        
        return cell;
    }
}
