//
//  TransactionViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 14/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    @IBOutlet weak var transactionTableView: UITableView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        transactionTableView.register(UINib.init(nibName: "TransactionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TransactionTableViewCell");
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let longTitleLabel = UILabel()
        longTitleLabel.text = "TRANSACTIONS"
        longTitleLabel.textColor = UIColor.white;
        let leftItem = UIBarButtonItem(customView: longTitleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
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

}

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell;
        
        
        return cell;
    }
}
