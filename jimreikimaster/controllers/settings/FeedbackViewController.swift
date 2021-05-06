//
//  FeedbackViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 13/02/2021.
//  Copyright © 2021 Cenes_Dev. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var feedbacktextView: UIView!;
    @IBOutlet weak var feedbacktextField: UITextField!;
    @IBOutlet weak var btnSubmit: UIButton!;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.feedbacktextView.dropGradientShadow();
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
        longTitleLabel.text = "FEEDBACK"
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

    @IBAction func submitButtonPressed(sender: UIButton) {
        
    }
}
