//
//  BookAppointmentPersonalInfoViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 13/02/2021.
//  Copyright © 2021 Cenes_Dev. All rights reserved.
//

import UIKit

class BookAppointmentPersonalInfoViewController: UIViewController, PersonallInfoViewControllerProtocol {

    @IBOutlet weak var personalInfoTableView: UITableView!
    @IBOutlet weak var nextBtn: UIButton!;
    var selectedCountry: CountryCodeService!;

    var healee: Healee!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.healee = Healee();
        self.personalInfoTableView.register(UINib.init(nibName: "BookAppointmentPersonalInfoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookAppointmentPersonalInfoTableViewCell");
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
        longTitleLabel.text = "BOOK APPOINTMENT - 2"
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
    
    @IBAction func nextBtnPressed(sender: UIButton) {
        
        if (healee.name == nil || healee.name == "") {
            showAlert(title: AlertTitle.ALERT, message: AlertMessage.NAME_EMPTY)
            return;
        }
        if (healee.gender == nil || healee.gender == "") {
            showAlert(title: AlertTitle.ALERT, message: AlertMessage.GENDER_EMPTY)
            return;
        }
        if (healee.address == nil || healee.address == "") {
            showAlert(title: AlertTitle.ALERT, message: AlertMessage.ADDRESS_EMPTY)
            return;
        }
        if (healee.description == nil || healee.description == "") {
            showAlert(title: AlertTitle.ALERT, message: AlertMessage.DESCIPTION_EMPTY)
            return;
        }
        
        currentTransaction.healee = self.healee;
        let viewController = storyboard?.instantiateViewController(identifier: "BookAppointmentPhotoViewController") as! BookAppointmentPhotoViewController;
        self.navigationController?.pushViewController(viewController, animated: true);
    }

    @objc func genderButtonPressed() {
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Male", style: .default) { action -> Void in

            self.healee.gender = "Male";
            self.personalInfoTableView.reloadData();
        }

        let secondAction: UIAlertAction = UIAlertAction(title: "Female", style: .default) { action -> Void in

            self.healee.gender = "Female";
            self.personalInfoTableView.reloadData();
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)


        // present an actionSheet...
        // present(actionSheetController, animated: true, completion: nil)   // doesn't work for iPad

        actionSheetController.popoverPresentationController?.sourceView = self.view // works for both iPhone & iPad

        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
    }
    
    @objc func nameTextFieldDidChange(_ textField: UITextField) {
        self.healee.name = textField.text;
    }

    @objc func addressTextFieldDidChange(_ textField: UITextField) {
        self.healee.address = textField.text;
    }

    @objc func descriptionTextFieldDidChange(_ textField: UITextField) {
        self.healee.description = textField.text;
    }
    
    @objc func cityTextFieldDidChange(_ textField: UITextField) {
        self.healee.city = textField.text;
    }
    
    @objc func stateTextFieldDidChange(_ textField: UITextField) {
        self.healee.state = textField.text;
    }
    
    @objc func countryViewPressed() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CountryListViewController") as! CountryListViewController;
        viewController.personalInfoViewProtocolProtocol = self;
        self.navigationController?.pushViewController(viewController, animated: true);
    }
    
    func countryPressed(countryObject: CountryCodeService) {
        self.selectedCountry = countryObject;
        self.healee.country = countryObject.getName();
        self.personalInfoTableView.reloadData();
    }

}

extension BookAppointmentPersonalInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookAppointmentPersonalInfoTableViewCell") as! BookAppointmentPersonalInfoTableViewCell;
        
        cell.bookAppointmentPersonalInfoDelegate = self;
        
        let genderTabGesture = UITapGestureRecognizer.init(target: self, action: #selector(genderButtonPressed));
        cell.genderLabelViewView.addGestureRecognizer(genderTabGesture);
        
        if (self.healee.gender != nil && self.healee.gender != "") {
            cell.genderLabel.text = self.healee.gender;
            cell.genderLabel.textColor = UIColor.black;
        }
        
        cell.nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange(_:)), for: .editingChanged);
        cell.addressTextField.addTarget(self, action: #selector(addressTextFieldDidChange(_:)), for: .editingChanged);
        cell.descriptionTextField.addTarget(self, action: #selector(descriptionTextFieldDidChange(_:)), for: .editingChanged);
        cell.cityTextField.addTarget(self, action: #selector(descriptionTextFieldDidChange(_:)), for: .editingChanged);
        cell.stateTextField.addTarget(self, action: #selector(descriptionTextFieldDidChange(_:)), for: .editingChanged);
        
        let countryViewTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(countryViewPressed));
        cell.countyView.addGestureRecognizer(countryViewTapGesture);
        
        if (self.selectedCountry != nil) {
            cell.countryLabel.text = self.selectedCountry.getName();
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 990;
    }
}
