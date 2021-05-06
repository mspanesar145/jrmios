//
//  PaymentSuccessViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 17/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class PaymentSuccessViewController: UIViewController {

    @IBOutlet weak var successErrorTitle: UILabel!;
    @IBOutlet weak var successErrorImg: UIImageView!
    @IBOutlet weak var successErrorMsg: UILabel!;
    @IBOutlet weak var retryText: UILabel!;
    @IBOutlet weak var doneButton: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func doneButtonPressed(sender: UIButton) {
        UIApplication.shared.keyWindow?.rootViewController = HomeViewController.MainViewController();
    }

}
