//
//  LoginFieldsTableViewCell.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 19/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginFieldsTableViewCell: UITableViewCell {

    @IBOutlet weak var emailTextField: UITextField!;
    @IBOutlet weak var passwordTextField: UITextField!;

    @IBOutlet weak var emailTextFieldView: UIView!;
    @IBOutlet weak var passwordTextFieldView: UIView!;
    @IBOutlet weak var forgetPasswordLink: UILabel!;
    @IBOutlet weak var loginBtn: UIButton!;
    @IBOutlet weak var signupBtn: UIButton!;

    var loginViewControllerDelegate: LoginViewController!;
    let loginButton = FBLoginButton();

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.emailTextFieldView.rounderCornerViewWithBorder();
        self.passwordTextFieldView.rounderCornerViewWithBorder();
        self.loginBtn.rounderCornerButton();

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    @IBAction func loginBtnPressed(sender: UIButton) {
        
        if (self.emailTextField.text! == "") {
            self.loginViewControllerDelegate.showAlert(title: AlertTitle.ALERT, message: AlertMessage.EMAIL_EMPTY);
        } else if (self.passwordTextField.text! == "") {
            self.loginViewControllerDelegate.showAlert(title: AlertTitle.ALERT, message: AlertMessage.PASSWORD_EMPTY);
        } else {
            
            let user = User();
            user.email = self.emailTextField.text!;
            user.password = self.passwordTextField.text!;
            self.loginViewControllerDelegate.loginRequest(user: user);
        }
    }
    
    @IBAction func signUpBtnPressed(sender: UIButton) {
        UIApplication.shared.keyWindow?.rootViewController = SignupViewController.MainViewController();
    }
    
}
