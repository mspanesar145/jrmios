//
//  BookAppointmentPaymentOptionsViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 03/10/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit
import Stripe
import PassKit

class BookAppointmentPaymentOptionsViewController: UIViewController,  STPPaymentContextDelegate, STPAddCardViewControllerDelegate  {
    
    @IBOutlet weak var paymentOptionTableView: UITableView!;
    @IBOutlet weak var nextBtn: UIButton!;
    
    var activityIndicator: UIActivityIndicatorView!;
    var bookAppointmentPaymentOptionTableViewCellDelegate: BookAppointmentPaymentOptionTableViewCell!;
    let companyName = "JRM"
    
    var customerContext: STPCustomerContext!;
    var paymentContext: STPPaymentContext!;
    var paymentIntentClientSecret: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        STPPaymentConfiguration.shared.requiredShippingAddressFields = [STPContactField.postalAddress, STPContactField.name];
        
        // Do any additional setup after loading the view.
        paymentOptionTableView.register(UINib.init(nibName: "BookAppointmentPaymentOptionTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookAppointmentPaymentOptionTableViewCell");
        
        self.getStripesTokenFromServer();
        

    }
        
    override func viewWillAppear(_ animated: Bool) {
        let longTitleLabel = UILabel()
        longTitleLabel.text = "BOOK APPOINTMENT - 3"
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //STEP - I
    //First Create Payment Session
    func getStripesTokenFromServer() {
        
        if (loggedInUser.customerId == "") {
            
            var postData = [String: Any]();
            postData["name"] = loggedInUser.name;
            postData["address"] = currentTransaction.healee.address;
            postData["description"] = loggedInUser.name;
            postData["userId"] = loggedInUser.userId;
            postData["email"] = loggedInUser.email;

            HttpService().makePostRequest(apiUrl: HomeAPI.post_stripe_create_customer, postData: postData, complete: {response in
                    
                let customer  = response.value(forKey: "data") as! NSDictionary;
                
                let address = customer.value(forKey: "address") as! NSDictionary;
                dbHelper.updateUserCustomerIdAndAddress(userId: loggedInUser.userId, customerId: customer.value(forKey: "id") as! String, address: address.value(forKey: "line1") as! String);
                
                loggedInUser = dbHelper.findLoggedInUser();
                
                self.customerContext = STPCustomerContext(keyProvider: StripeApiClient());
                self.customerContext.clearCache();
                self.paymentContext = STPPaymentContext(customerContext: self.customerContext)
                //super.init(nibName: nil, bundle: nil)
                self.paymentContext.delegate = self
                self.paymentContext.hostViewController = self
                self.paymentContext.paymentAmount = 1 // This is in cents, i.e. $50 USD

            });
        } else {
            
            self.customerContext = STPCustomerContext(keyProvider: StripeApiClient());
            self.customerContext.clearCache();
            self.paymentContext = STPPaymentContext(customerContext: self.customerContext)
            //super.init(nibName: nil, bundle: nil)
            self.paymentContext.delegate = self
            self.paymentContext.hostViewController = self
            self.paymentContext.paymentAmount = 1 // This is in cents, i.e. $50 USD

        }

    }
    
    @IBAction func nextBtnPressed(sender: UIButton) {

        //self.paymentContext.pushShippingViewController();
        
        self.paymentContext.requestPayment();

        //choosePaymentButtonTapped();
        /*let paymentSuccessViewController = storyboard?.instantiateViewController(identifier: "PaymentSuccessViewController") as! PaymentSuccessViewController;
        self.navigationController?.pushViewController(paymentSuccessViewController, animated:  true);*/
    }
    
    @objc func creditCardPressed() {
        
        self.bookAppointmentPaymentOptionTableViewCellDelegate.creditCardCheckboxImage.image = UIImage.init(named: "agree_check");
        self.bookAppointmentPaymentOptionTableViewCellDelegate.paypalCheckboxImage.image = UIImage.init(named: "agree_uncheck");
    }
    
    @objc func paypalPressed() {
        self.bookAppointmentPaymentOptionTableViewCellDelegate.creditCardCheckboxImage.image = UIImage.init(named: "agree_uncheck");
        self.bookAppointmentPaymentOptionTableViewCellDelegate.paypalCheckboxImage.image = UIImage.init(named: "agree_check");
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext,
      didFinishWithStatus status: STPPaymentStatus,
      error: Error?) {

        switch status {
        case .error:
            print("Error", error);
        case .success:
            print("Success");
        case .userCancellation:
            print("userCancellation");
            return // Do nothing
        }
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        
        print("Error");
        if (paymentContext.selectedPaymentOption != nil) {
            //self.paymentContext.requestPayment();
        }

    }

    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        
        print("Error", error)
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        
        var postData = [String: Any]();
        postData["amount"] = paymentContext.paymentAmount;
        postData["customerId"] = loggedInUser.customerId;
        postData["description"] = "\(currentTransaction.reikiService.title!) - Duration : \(currentTransaction.reikiSession.sessionInterval) - Days : \(currentTransaction.reikiSession.sessionDays)";

        HttpService().makePostRequest(apiUrl: HomeAPI.post_stripe_payment_intent, postData: postData, complete: {response in
            
            let clientSecret = response.value(forKey: "data") as! String;
            // Assemble the PaymentIntent parameters
            let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
            paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId

            // Confirm the PaymentIntent
            STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams, authenticationContext: paymentContext) { status, paymentIntent, error in
                switch status {
                case .succeeded:
                    // Your backend asynchronously fulfills the customer's order, e.g. via webhook
                    completion(.success, nil)
                case .failed:
                    completion(.error, error) // Report error
                case .canceled:
                    completion(.userCancellation, nil) // Customer cancelled
                @unknown default:
                    completion(.error, nil)
                }
            }
        });
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        
        print("didFinishWith", error)

    }
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        
                print("addCardViewControllerDidCancel")

    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
        
                print("addCardViewController")

    }

}

extension BookAppointmentPaymentOptionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 540;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookAppointmentPaymentOptionTableViewCell") as! BookAppointmentPaymentOptionTableViewCell;
        
        let creditCardTapGuesture = UITapGestureRecognizer.init(target: self, action: #selector(creditCardPressed));
        cell.creditCardCheckboxView.addGestureRecognizer(creditCardTapGuesture);
        
        let paypalTapGuesture = UITapGestureRecognizer.init(target: self, action: #selector(paypalPressed));
        cell.paypalCheckboxView.addGestureRecognizer(paypalTapGuesture);

        cell.bookAppointmentPaymentOptionDelegate = self;
        self.bookAppointmentPaymentOptionTableViewCellDelegate = cell;
        return cell;
    }
}
