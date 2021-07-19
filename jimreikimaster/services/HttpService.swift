//
//  HttpService.swift
//  jimreikimaster
//
//  Created by Cenes_Dev on 30/09/2020.
//  Copyright © 2020 Cenes_Dev. All rights reserved.
//

import Foundation
import Alamofire

class HttpService {
    

    func makePostRequest(apiUrl: String, postData: [String: Any],complete: @escaping(NSDictionary)->Void) {
        
        let header: HTTPHeaders = ["Content-Type": "application/json",
                      "accept": "application/json"];
        
        print("API : \(ApiService.API_ENDPOINT)\(apiUrl)");
        print("POST Data : \(postData)")
        AF.request("\(ApiService.API_ENDPOINT)\(apiUrl)", method: .post, parameters: postData, encoding: JSONEncoding.default, headers: header).validate(statusCode: 200..<300).responseJSON { (response ) in
            print("Response : \(response)");
            
            var returnedDict = NSDictionary();

            switch response.result {
                case .success:
                    
                    returnedDict =  response.value as! NSDictionary;

                case .failure(let error):
                    print(error.localizedDescription)
                    var responseDict: [String: Any] = [:]
                    responseDict["success"] = false;
                    responseDict["message"] = error.localizedDescription;
                    returnedDict = responseDict as NSDictionary;
            }  
            complete(returnedDict);
        };
    }
    
    func makeGetRequest(apiUrl: String,complete: @escaping(NSDictionary)->Void) {
        
        print("API : \(ApiService.API_ENDPOINT)\(apiUrl)");
        AF.request("\(ApiService.API_ENDPOINT)\(apiUrl)", method: .get).responseJSON(completionHandler: {response in
            
            var returnedDict = NSDictionary();
            switch response.result {
                case .success(let successResp):
                        
                    returnedDict = response.value as! NSDictionary;
                    print("Response : \(returnedDict)");
                case .failure(let error):
                    returnedDict.setValue(false, forKey: "success");
                    returnedDict.setValue(error.localizedDescription, forKey: "message");

                    print(error);
            }
            complete(returnedDict);
        });
    }
    
    func postMultipartImageForHealee(url: String, image: UIImage, complete: @escaping(NSDictionary)->Void) {
        
        print("API : \(ApiService.API_ENDPOINT)\(url)");
        let requestUrl = "\(ApiService.API_ENDPOINT)\(url)";

        let imgData = image.jpegData(compressionQuality: 0.2)!
                
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 500;
        let headers: HTTPHeaders = [
          "Connection": "Close"
        ]

        manager.upload(multipartFormData: { (MultipartFormData) in
            MultipartFormData.append(imgData, withName: "userfile", fileName: "file.jpg", mimeType: "image/jpg")
        }, to: requestUrl, method: .post, headers: headers).responseJSON(completionHandler: {(response) in
            debugPrint("SUCCESS RESPONSE: \(response.result)")
            var returnDict = NSDictionary();

            switch response.result {
            case .success(let upload):
                if (upload == nil) {
                    var responseDict: [String: Any] = [:]
                    responseDict["status"] = "0";
                    responseDict["message"] = "Connection timeout";
                    returnDict = responseDict as NSDictionary;
                } else {
                    returnDict = upload as! NSDictionary;
                }
                complete(returnDict)
                    
            case .failure(let encodingError):
                print(encodingError)
                var responseDict: [String: Any] = [:]
                responseDict["status"] = "0";
                responseDict["message"] = encodingError.localizedDescription;
                returnDict = responseDict as NSDictionary;
                complete(returnDict)

            }
        });
    }
}
