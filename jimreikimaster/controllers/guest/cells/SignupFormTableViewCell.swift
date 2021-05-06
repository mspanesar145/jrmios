//
//  SignupFormTableViewCell.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 19/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn

class SignupFormTableViewCell: UITableViewCell {

    @IBOutlet weak var emailTextField: UITextField!;
    @IBOutlet weak var passwordTextField: UITextField!;
    @IBOutlet weak var nameTextField: UITextField!;
    @IBOutlet weak var phoneTextField: UITextField!;
    @IBOutlet weak var phoneCodeView: UIView!;
    @IBOutlet weak var phoneCodeLabel: UILabel!;

    @IBOutlet weak var nameTextFieldView: UIView!;
    @IBOutlet weak var emailTextFieldView: UIView!;
    @IBOutlet weak var passwordTextFieldView: UIView!;
    @IBOutlet weak var phoneTextFieldView: UIView!;
    @IBOutlet weak var googleLoginView: UIView!;
    @IBOutlet weak var facebookLoginView: UIView!;

    @IBOutlet weak var signUpBtn: UIButton!;
    @IBOutlet weak var loginBtn: UIButton!;

    @IBOutlet weak var acceptTermsAndCondsLabel: UILabel!;
    @IBOutlet weak var tandCCheckbox: UIImageView!;

    var signupViewControllerDelegate: SignupViewController!;
    let loginButton = FBLoginButton();
    var tandcChecked: Bool = false;
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameTextFieldView.rounderCornerViewWithBorder();
        emailTextFieldView.rounderCornerViewWithBorder();
        passwordTextFieldView.rounderCornerViewWithBorder();
        phoneTextFieldView.rounderCornerViewWithBorder();
        googleLoginView.circleView();
        facebookLoginView.circleView();
        signUpBtn.rounderCornerButton();
        
        loginButton.permissions = ["public_profile", "email"];
        
        let fbGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(facebookBtnPressed));
        facebookLoginView.addGestureRecognizer(fbGestureRecognizer);
        
        let googleGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(googleBtnPressed));
        googleLoginView.addGestureRecognizer(googleGestureRecognizer);

        let phoneCodeViewGesture = UITapGestureRecognizer.init(target: self, action: #selector(phoneCodeViewPressed));
        phoneCodeView.addGestureRecognizer(phoneCodeViewGesture);
        
        let tandcPressedGesture = UITapGestureRecognizer.init(target: self, action: #selector(tandcPressed));
        tandCCheckbox.addGestureRecognizer(tandcPressedGesture);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func loginBtnPressed(sender: UIButton) {
        UIApplication.shared.keyWindow?.rootViewController = LoginViewController.MainViewController();
    }
    
    @IBAction func signUpBtnPressed(sender: UIButton) {
        
        if (self.nameTextField.text! == "") {
            self.signupViewControllerDelegate.showAlert(title: AlertTitleEnum.ALERT, message: AlertMessage.NAME_EMPTY);
        } else if (self.emailTextField.text! == "") {
            self.signupViewControllerDelegate.showAlert(title: AlertTitleEnum.ALERT, message: AlertMessage.EMAIL_EMPTY);
        }  else if (self.phoneTextField.text! == "") {
           self.signupViewControllerDelegate.showAlert(title: AlertTitleEnum.ALERT, message: AlertMessage.PHONE_EMPTY);
        }  else if (self.phoneCodeLabel.text! == "") {
                self.signupViewControllerDelegate.showAlert(title: AlertTitleEnum.ALERT, message: AlertMessage.COUNTRY_CODE_EMPTY);
        } else if (self.passwordTextField.text! == "") {
               self.signupViewControllerDelegate.showAlert(title: AlertTitleEnum.ALERT, message: AlertMessage.PASSWORD_EMPTY);
        } else if (tandcChecked == false) {
            self.signupViewControllerDelegate.showAlert(title: AlertTitleEnum.ALERT, message: AlertMessage.TANDC_NOT_CHECKED);
        }else {
            
            let user = User();
            user.name = self.nameTextField.text!;
            user.email = self.emailTextField.text!;
            user.phone = self.phoneTextField.text!;
            user.phoneCode = self.phoneCodeLabel.text!;
            user.password = self.passwordTextField.text!;
            
            signupViewControllerDelegate.signupRequest(user: user);
        }
    }
    
    @objc func facebookBtnPressed() {
        
        var loginManager = LoginManager();
        loginManager.logIn(permissions: ["public_profile", "email"], from: signupViewControllerDelegate, handler: {(result, error) in
            
            if (error != nil) {
                print(error?.localizedDescription);
            } else if (result?.isCancelled == true) {
                print("Cancelled");
            } else {
                
                if let token = AccessToken.current {
                    self.fetchUserProfile();
                }
            }
            
        });
    }
    
    @objc func googleBtnPressed() {
        self.signupViewControllerDelegate.openGoogleLoginDialog();
    }
    
    
    @objc func phoneCodeViewPressed() {
        
        let viewController = self.signupViewControllerDelegate.storyboard?.instantiateViewController(withIdentifier: "CountryListViewController") as! CountryListViewController;
        viewController.signupViewControllerProtocol = self.signupViewControllerDelegate;
        self.signupViewControllerDelegate.navigationController?.pushViewController(viewController, animated: true);

    }
    
    @objc func tandcPressed() {
        
        if (tandcChecked == true) {
            self.tandCCheckbox.image = UIImage.init(named: "agree_uncheck");
            tandcChecked = false;
        } else {
            self.tandCCheckbox.image = UIImage.init(named: "agree_check");
            tandcChecked = true;
        }
    }
    
    func fetchUserProfile() {
        
        let graphRequest = GraphRequest.init(graphPath: "me", parameters: ["fields": "id, email, name, picture.width(480).height(480)"]);
        graphRequest.start(completionHandler: {(connection, result, error) in
            if ((error) != nil) {
               print("Error took place: \(error)")
            } else {
                print("Print entire fetched result: \(result)")
                let fbResponseDict = result as! NSDictionary;
                self.signupViewControllerDelegate.user.facebookId = fbResponseDict.value(forKey: "id") as! String;
                self.signupViewControllerDelegate.user.name = fbResponseDict.value(forKey: "name") as! String;
                self.nameTextField.text = self.signupViewControllerDelegate.user.name;
                
                if let email = fbResponseDict.value(forKey: "email") as? String {
                    self.signupViewControllerDelegate.user.email = email;
                    self.emailTextField.text = email;
                }
                
                if let profilePictureObj = fbResponseDict.value(forKey: "picture") as? NSDictionary {
                    
                    let data = profilePictureObj.value(forKey: "data") as! NSDictionary
                    self.signupViewControllerDelegate.user.photo = data.value(forKey: "url") as! String
                }
            }
        });
    }

}
