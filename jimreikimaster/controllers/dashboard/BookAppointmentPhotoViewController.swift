//
//  BookAppointmentPhotoViewController.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 26/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices
import Mantis

protocol BookAppointmentPhotoTableViewCellProtocol {
    func uploadImageAndGetUrl(imageToUpload: UIImage);
}

class BookAppointmentPhotoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {

    @IBOutlet weak var photoUploadTableView: UITableView!;
    @IBOutlet weak var nextBtn: UIButton!;
    
    let picController = UIImagePickerController();
    var bookAppointmentPhotoTableViewCellDelegate: BookAppointmentPhotoTableViewCellProtocol!;
    var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoUploadTableView.register(UINib.init(nibName: "BookAppointmentPhotoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookAppointmentPhotoTableViewCell");
        
        self.loadingIndicator.isHidden = true;
        self.loadingIndicator.style = .medium;
    
    }
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func browseImagePressed() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            picController.delegate = self
            picController.sourceType = UIImagePickerController.SourceType.photoLibrary;
            //picController.allowsEditing = true
            picController.mediaTypes = [kUTTypeImage as String]
            self.present(picController, animated: true, completion: nil)
        }
    }

    @IBAction func nextBtnPressed() {
        let paymentOptionViewController = storyboard?.instantiateViewController(identifier: "BookAppointmentPaymentOptionsViewController") as! BookAppointmentPaymentOptionsViewController;
        self.navigationController?.pushViewController(paymentOptionViewController, animated: true);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    // Local variable inserted by Swift 4.2 migrator.
    let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

            if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
                picker.dismiss(animated: true, completion: nil);
                let cropViewController = Mantis.cropViewController(image: image)
                cropViewController.delegate = self
                cropViewController.modalPresentationStyle = .fullScreen
                self.present(cropViewController, animated: true)
            }
            
        }
    
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        cropViewController.dismiss(animated: true, completion: {
            if (self.bookAppointmentPhotoTableViewCellDelegate != nil) {
                //event.imageToUpload = UIImage(data: UIImageJPEGRepresentation(image, UIImage.JPEGQuality.lowest.rawValue)!);
                self.bookAppointmentPhotoTableViewCellDelegate.uploadImageAndGetUrl(imageToUpload: cropped);
                
                self.loadingIndicator.isHidden = false;
                self.loadingIndicator.startAnimating();
                
                HttpService().postMultipartImageForHealee(url: HomeAPI.post_upload_healee_photo, image: cropped, complete: {response in
                    
                    self.loadingIndicator.isHidden = true;
                    self.loadingIndicator.stopAnimating();

                    let success = response.value(forKey: APIResponseEnum.STATUS) as! String;
                    if (success == APIResponseEnum.SUCCESS) {
                        let healee = currentTransaction.healee;
                        healee?.photo = (response.value(forKey: APIResponseEnum.DATA) as! String);
                        currentTransaction.healee = healee;
                    }
                });
            } else {
                self.showAlert(title: "Error", message: "Cannot upload from screenshot")
            }
        });
    }
    func cropViewControllerDidFailToCrop(_ cropViewController: CropViewController, original: UIImage) {}
    
    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        cropViewController.dismiss(animated: true, completion: {
            
        });
    }
}

extension BookAppointmentPhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 650;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookAppointmentPhotoTableViewCell", for: indexPath) as! BookAppointmentPhotoTableViewCell;
        self.bookAppointmentPhotoTableViewCellDelegate.self = cell;
        
        let browseBtnTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(browseImagePressed));
        cell.uploadPhotoBrowseBtn.addGestureRecognizer(browseBtnTapGesture);
        
        self.loadingIndicator.frame = CGRect.init(x: cell.uploadPhotoContainerView.frame.width/2 - self.loadingIndicator.frame.width/2, y:  cell.uploadPhotoContainerView.frame.height/2 - self.loadingIndicator.frame.height/2, width: self.loadingIndicator.frame.width, height: self.loadingIndicator.frame.height)
        cell.uploadPhotoContainerView.addSubview(self.loadingIndicator);
        return cell;
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
