//
//  UIViewController+Extension.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 30/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title : String ,message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            print ("Ok")
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true);
    }
    
    @objc func menuButtonPressed() {
        let settingViewController = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController;
        navigationController?.pushViewController(settingViewController, animated: true);
    }
}
