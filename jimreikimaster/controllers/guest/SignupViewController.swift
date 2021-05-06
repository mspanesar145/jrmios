//
//  SignupViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 19/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignupViewController: UIViewController, GIDSignInDelegate, SignupViewControllerProtocol {
    
    class func MainViewController() -> UINavigationController {
        
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signupNav") as! UINavigationController
        return navController
        
    }
    
    @IBOutlet weak var signupFormTableView: UITableView!;
    var selectedCountry: CountryCodeService!;
    var checkBoxActive: Bool = false;
    var user = User();
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signupFormTableView.register(UINib.init(nibName: "SignupFormTableViewCell", bundle: nil), forCellReuseIdentifier: "SignupFormTableViewCell");
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "133688414856-bulvfb2qbi1momf7pcogibsb6ilr6msq.apps.googleusercontent.com";
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self;

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func signupRequest(user: User) {
        
        var postData = [String: Any]();
        postData["email"] = user.email;
        postData["password"] = user.password;
        postData["fullname"] = user.name;
        if (self.selectedCountry != nil) {
            postData["countryCode"] = self.selectedCountry.getPhoneCode();
        } else if (user.phoneCode != nil) {
            postData["countryCode"] = user.phoneCode;
        }
        postData["phoneNumber"] = user.phone;

        HttpService().makePostRequest(apiUrl: UserAPI.post_signup_request, postData: postData, complete: {response in
            
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
    
    func countryPressed(countryObject: CountryCodeService) {
        self.selectedCountry = countryObject;
        self.signupFormTableView.reloadData();
    }
    
    func openGoogleLoginDialog() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      self.user.name = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
        self.user.email = user.profile.email
      // ...
        self.signupFormTableView.reloadData();
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
}

extension SignupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 763;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignupFormTableViewCell", for: indexPath) as! SignupFormTableViewCell;
        cell.signupViewControllerDelegate = self;
        if (self.selectedCountry != nil) {
            cell.phoneCodeLabel.text = self.selectedCountry.getPhoneCode();
        }
        if (user.email != "") {
            cell.emailTextField.text = user.email;
        }
        if (user.name != "") {
            cell.nameTextField.text = user.name;
        }
        return cell;
    }
}
