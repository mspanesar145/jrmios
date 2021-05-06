//
//  ContactUsViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 13/02/2021.
//  Copyright © 2021 Cenes_Dev. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    
    @IBOutlet weak var phoneView: UIView!;
    @IBOutlet weak var instagramView: UIView!;
    @IBOutlet weak var EmailView: UIView!;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.phoneView.dropGradientShadow();
        self.instagramView.dropGradientShadow();
        self.EmailView.dropGradientShadow();

        
        let phoneViewGesture = UITapGestureRecognizer.init(target: self, action: #selector(phoneViewPressed));
        self.phoneView.addGestureRecognizer(phoneViewGesture);
        
        let instaViewGesture = UITapGestureRecognizer.init(target: self, action: #selector(instaViewPressed));
        self.instagramView.addGestureRecognizer(instaViewGesture)

        
        let emailViewGesture = UITapGestureRecognizer.init(target: self, action: #selector(emailViewPressed));
        self.EmailView.addGestureRecognizer(emailViewGesture)

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
        longTitleLabel.text = "CONTACT US"
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
    
    @objc func phoneViewPressed() {
        if let url = NSURL(string: ("tel:" + JrmConstants.reikiMasterPhone)) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    @objc func instaViewPressed() {
        guard let instagram = URL(string: JrmConstants.reikiMasterInstaProfile) else { return }
        UIApplication.shared.open(instagram)
    }

    
    @objc func emailViewPressed() {
        if let emailURL = URL(string: "mailto:\(JrmConstants.reikiMasterEmail)"), UIApplication.shared.canOpenURL(emailURL) {
            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
        }
    }

}
