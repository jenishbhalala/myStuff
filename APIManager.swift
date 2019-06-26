//
//  APIManager2.swift
//  Jenish
//
//  Created by Jenish on 08/09/2018.
//  Copyright © 2018  Jenish. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration
import AVKit
import AVFoundation
import SVProgressHUD


class APIManager: NSObject {
    
    static let apiManager = APIManager()

   // let Deviceudid = UserDefaults.standard.string(forKey: "DEVICE_UUID") as? String
    
    func postApi(url:String,param:AnyObject,isAuthenticated: Bool,completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){
        
        
        var header = [String:String]()
        if isAuthenticated {
            header = ["Accept": "application/json",
                      "Authorization": "Bearer \(CustomerManager.shared.api_token)",
                      "Device-Id":DEVICE_ID]
        } else {
            header = ["Accept": "application/json",
                      "Device-Id":DEVICE_ID]
        }
        
        print("--------------------------------------------------------------------")
        print("Url : ", url)
        print("--------------------------------------------------------------------")
        print("Param : ",param)
        print("--------------------------------------------------------------------")
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param as? Parameters, encoding: JSONEncoding.default, headers: header as [String:String]).responseJSON(completionHandler: { (response) in
            print(response)
            if let data = response.result.value as? [String: Any] {
                print("Response : ", data)
                print("--------------------------------------------------------------------")
                if (data["message"] as? String == "Unauthenticated" || data["message"] as? String == "Unauthenticated".localized()) && isGuest == false {
                    hideProgress()
                    CustomerManager.removeModel()
                    APP_DELEGATE.setupInitials()
                }

                completionHandler(data as AnyObject?, nil)
            }
            else{
                
                print(response.result)
                print(response.result.error as Any)
                completionHandler(nil,response.result.error as NSError?)
            }
        })
    }
    func patchApi(url:String,param:AnyObject,isAuthenticated: Bool,completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){

        var header = [String:String]()
        if isAuthenticated {
            header = ["Authorization": "Bearer \(CustomerManager.shared.api_token)",
                    "Accept": "application/json",
                    "Device-Id":DEVICE_ID]
        } else {
            header = ["Accept": "application/json",
                      "Device-Id":DEVICE_ID]
        }
        print("--------------------------------------------------------------------")
        print("Url : ", url)
        print("--------------------------------------------------------------------")
        print("Param : ",param)
        print("--------------------------------------------------------------------")
        
        Alamofire.request(url, method: HTTPMethod.patch, parameters: param as? Parameters, encoding: JSONEncoding.default, headers: header as [String:String]).responseJSON(completionHandler: { (response) in
            print(response)
            if let data = response.result.value as? [String: Any] {
                print("Response : ", data)
                print("--------------------------------------------------------------------")
                if (data["message"] as? String == "Unauthenticated" || data["message"] as? String == "Unauthenticated".localized()) && isGuest == false {
                    hideProgress()
                    CustomerManager.removeModel()
                    APP_DELEGATE.setupInitials()
                }

                completionHandler(data as AnyObject?, nil)
            }
            else{
                
                print(response.result)
                print(response.result.error as Any)
                completionHandler(nil,response.result.error as NSError?)
            }
        })
    }
    func getApi(url:String,param:AnyObject,isAuthentictaed: Bool,completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){


        var header = [String:String]()
        if isAuthentictaed {
            header = ["Authorization": "Bearer \(CustomerManager.shared.api_token)",
                "Accept": "application/json","Device-Id":DEVICE_ID]
        } else {
            header = ["Accept": "application/json","Device-Id":DEVICE_ID]
        }
        // let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: header as [String:String]).responseJSON(completionHandler: { (response) in
            switch (response.result) {
            case .success:
                if let data = response.result.value as? [String: Any] {
                    print("--------------------------------------------------------------------")
                    print("URL : ",url)
                    print("--------------------------------------------------------------------")
                    print("Response : ", data)
                    print("--------------------------------------------------------------------")
                    if (data["message"] as? String == "Unauthenticated" || data["message"] as? String == "Unauthenticated".localized()) && isGuest == false {
                        hideProgress()
                        CustomerManager.removeModel()
                        APP_DELEGATE.setupInitials()
                    }

                    completionHandler(data as AnyObject?, nil)
                }else if let data = response.result.value as? NSArray{
                    completionHandler(data as AnyObject?, nil)
                }
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    hideProgress()
                    completionHandler(nil,response.result.error as NSError?)
                    
                }
                hideProgress()
                print("\n\nAuth request failed with error:\n \(error.localizedDescription)")
                break
            }
        })
    }
    func getApiEndoing(url:String,param:AnyObject,isAuthentictaed: Bool,completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){
        
        
        var header = [String:String]()
        if isAuthentictaed {
            header = ["Authorization": "Bearer \(CustomerManager.shared.api_token)",
                "Accept": "application/json","Device-Id":DEVICE_ID]
        } else {
            header = ["Accept": "application/json","Device-Id":DEVICE_ID]
        }
         let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(encodedUrl ?? "", method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: header as [String:String]).responseJSON(completionHandler: { (response) in
            switch (response.result) {
            case .success:
                if let data = response.result.value as? [String: Any] {
                    print("--------------------------------------------------------------------")
                    print("URL : ",url)
                    print("--------------------------------------------------------------------")
                    print("Response : ", data)
                    print("--------------------------------------------------------------------")
                    if (data["message"] as? String == "Unauthenticated" || data["message"] as? String == "Unauthenticated".localized()) && isGuest == false {
                        hideProgress()
                        CustomerManager.removeModel()
                        APP_DELEGATE.setupInitials()
                    }
                    
                    completionHandler(data as AnyObject?, nil)
                }else if let data = response.result.value as? NSArray{
                    completionHandler(data as AnyObject?, nil)
                }
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    hideProgress()
                    completionHandler(nil,response.result.error as NSError?)
                    
                }
                hideProgress()
                print("\n\nAuth request failed with error:\n \(error.localizedDescription)")
                break
            }
        })
    }

    func putApi(url:String,param:AnyObject,isAuthenticated: Bool,completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){

        var header = [String:String]()
        if isAuthenticated {
            header = ["Accept": "application/json",
                      "Authorization": "Bearer \(CustomerManager.shared.api_token)","Device-Id":DEVICE_ID]
        } else {
            header = ["Accept": "application/json","Device-Id":DEVICE_ID]
        }
        
        print("--------------------------------------------------------------------")
        print("Url : ", url)
        print("--------------------------------------------------------------------")
        print("Param : ",param)
        print("--------------------------------------------------------------------")
        
        Alamofire.request(url, method: HTTPMethod.put, parameters: param as? Parameters, encoding: JSONEncoding.default, headers: header as [String:String]).responseJSON(completionHandler: { (response) in
            print(response)
            if let data = response.result.value as? [String: Any] {
                print("Response : ", data)
                print("--------------------------------------------------------------------")
                if (data["message"] as? String == "Unauthenticated" || data["message"] as? String == "Unauthenticated".localized()) && isGuest == false {
                    hideProgress()
                    CustomerManager.removeModel()
                    APP_DELEGATE.setupInitials()
                }

                completionHandler(data as AnyObject?, nil)
            }
            else{
                
                print(response.result)
                print(response.result.error as Any)
                completionHandler(nil,response.result.error as NSError?)
            }
        })
    }
    func deleteApi(url:String,param:AnyObject,isAuthenticated: Bool,completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){
   
        var header = [String:String]()
        if isAuthenticated {
            header = ["Accept": "application/json",
                      "Authorization": "Bearer \(CustomerManager.shared.api_token)","Device-Id":DEVICE_ID]
        } else {
            header = ["Accept": "application/json","Device-Id":DEVICE_ID]
        }
        
        print("--------------------------------------------------------------------")
        print("Url : ", url)
        print("--------------------------------------------------------------------")
        print("Param : ",param)
        print("--------------------------------------------------------------------")
        
        Alamofire.request(url, method: HTTPMethod.delete, parameters: param as? Parameters, encoding: JSONEncoding.default, headers: header as [String:String]).responseJSON(completionHandler: { (response) in
            print(response)
            if let data = response.result.value as? [String: Any] {
                print("Response : ", data)
                print("--------------------------------------------------------------------")
                completionHandler(data as AnyObject?, nil)
                if (data["message"] as? String == "Unauthenticated" || data["message"] as? String == "Unauthenticated".localized()) && isGuest == false {
                    hideProgress()
                    CustomerManager.removeModel()
                    APP_DELEGATE.setupInitials()
                }

            }
            else{
                
                print(response.result)
                print(response.result.error as Any)
                completionHandler(nil,response.result.error as NSError?)
            }
        })
    }
    func upload(image:UIImage,url:String, isAuthentictaed: Bool, fileName: String,parameters:NSMutableDictionary,completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){

        var header = [String:String]()
        if isAuthentictaed {
            header = ["Authorization": "Bearer \(CustomerManager.shared.api_token)",
                "Accept": "application/json","Device-Id":DEVICE_ID]
        } else {
            header = ["Accept": "application/json","Device-Id":DEVICE_ID]
        }
        
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        
        print("--------------------------------------------------------------------")
        print("Url : ", url)
        print("--------------------------------------------------------------------")
        print("Param : ",parameters)
        print("--------------------------------------------------------------------")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "imageUrl",fileName: fileName, mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
            }
        },to:url, method: .post, headers: header) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    
                })
                upload.responseJSON { response in
                    debugPrint(response)
                    if let JSON = response.result.value as? [String: Any]{
                        print("--------------------------------------------------------------------")
                        print("Response : ",JSON)
                        print("--------------------------------------------------------------------")
                        completionHandler(JSON as AnyObject?, nil)
                    }
                    else{
                        
                    }
                }
            case .failure(let encodingError):
                if encodingError._code == NSURLErrorTimedOut {
                    completionHandler(nil,encodingError as NSError?)
                    
                }
                print(encodingError)
            }
        }
    }
    func postApiWithHeader(url:String,param:AnyObject,headers:[String:String],isAuthenticated: Bool,completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){
        
        var header : [String:String] = headers
        if isAuthenticated {
            header = ["Authorization": "Bearer \(CustomerManager.shared.api_token)","Device-Id":DEVICE_ID]
        } else {
            header = ["Accept": "application/json","Device-Id":DEVICE_ID]
        }
        
        print("--------------------------------------------------------------------")
        print("Url : ", url)
        print("--------------------------------------------------------------------")
        print("Param : ",param)
        print("--------------------------------------------------------------------")
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: param as? Parameters, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: { (response) in
            print(response)
            if let data = response.result.value as? [String: Any] {
                print("Response : ", data)
                print("--------------------------------------------------------------------")
                completionHandler(data as AnyObject?, nil)
            }
            else{
                
                print(response.result)
                print(response.result.error as Any)
                completionHandler(nil,response.result.error as NSError?)
            }
        })
    }
    func checkNetworkConnectivity()->String
    {
        let network:Reachability = Reachability();
        
        var networkValue:String = "" as String
        
        if(network.currentReachabilityStatus().rawValue==0)
        {
            networkValue = "NoAccess";
        }
        else if(network.currentReachabilityStatus().rawValue==1)
        {
            networkValue = "e";
        }
        else if(network.currentReachabilityStatus().rawValue==2)
        {
            networkValue = "wifi";
        }
        
        return networkValue;
    }
    
    func callNetworkAlert()
    {
        let alert = UIAlertController(title: "Bad Internet Connection!", message: "Please check your internet connection.", preferredStyle: UIAlertControllerStyle.alert)
        let action1 = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (dd) -> Void in
        }
        alert.addAction(action1)
    }
}
