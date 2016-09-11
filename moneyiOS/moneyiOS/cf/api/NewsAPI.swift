//
//  NewsAPI.swift
//  moneyiOS
//
//  Created by wang jam on 8/2/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import Alamofire

typealias responseCall = (error: NSError? ,responseData: NSDictionary?)->Void
typealias apiCall = (callback: responseCall) ->Void

class NewsAPI: NSObject {
    
    static let serverDomain = ConfigAccess.serverDomain()
    
    static func getHotNews(callback: responseCall){
        Alamofire.request(.GET, serverDomain + "news/hotNewslist", parameters: nil)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    let JSON = response.result.value as! NSDictionary
                    callback(error:nil, responseData: JSON)
                    break
                case .Failure(let error):
                    print(error)
                    callback(error: error, responseData: nil)
                    break
                }
            }
    }
    
    static func getAnnouncementList(callback: responseCall){
        Alamofire.request(.GET, serverDomain + "news/announcementList", parameters: nil)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    let JSON = response.result.value as! NSDictionary
                    callback(error:nil, responseData: JSON)
                    break
                case .Failure(let error):
                    print(error)
                    callback(error: error, responseData: nil)
                    break
                }
        }
    }
    
    static func getDepositlist(callback: responseCall){
        Alamofire.request(.GET, serverDomain + "news/depositlist", parameters: nil)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    let JSON = response.result.value as! NSDictionary
                    callback(error:nil, responseData: JSON)
                    break
                case .Failure(let error):
                    print(error)
                    callback(error: error, responseData: nil)
                    break
                }
        }
    }
    
    static func getPublishlist(callback: responseCall){
        Alamofire.request(.GET, serverDomain + "news/publishlist", parameters: nil)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    let JSON = response.result.value as! NSDictionary
                    callback(error:nil, responseData: JSON)
                    break
                case .Failure(let error):
                    print(error)
                    callback(error: error, responseData: nil)
                    break
                }
        }
    }
    
    static func getBenchmark(callback: responseCall){
        Alamofire.request(.GET, serverDomain + "news/getBenchmark", parameters: nil)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    let JSON = response.result.value as! NSDictionary
                    callback(error:nil, responseData: JSON)
                    break
                case .Failure(let error):
                    print(error)
                    callback(error: error, responseData: nil)
                    break
                }
        }
    }
    
    
    static func getForeign(callback: responseCall){
                Alamofire.request(.GET, serverDomain + "news/getForeign", parameters: nil)
                    .validate()
                    .responseJSON { response in
        
                        switch response.result {
                        case .Success:
                            let JSON = response.result.value as! NSDictionary
                            callback(error:nil, responseData: JSON)
                            break
                        case .Failure(let error):
                            print(error)
                            callback(error: error, responseData: nil)
                            break
                        }
                }
    }
    
    static func getRMB(callback: responseCall){
                Alamofire.request(.GET, serverDomain + "news/getRMB", parameters: nil)
                    .validate()
                    .responseJSON { response in
        
                        switch response.result {
                        case .Success:
                            let JSON = response.result.value as! NSDictionary
                            callback(error:nil, responseData: JSON)
                            break
                        case .Failure(let error):
                            print(error)
                            callback(error: error, responseData: nil)
                            break
                        }
                }
    }
    
    static func getCurve(callback: responseCall){
        //        Alamofire.request(.GET, serverDomain + "news/publishlist", parameters: nil)
        //            .validate()
        //            .responseJSON { response in
        //
        //                switch response.result {
        //                case .Success:
        //                    let JSON = response.result.value as! NSDictionary
        //                    callback(error:nil, responseData: JSON)
        //                    break
        //                case .Failure(let error):
        //                    print(error)
        //                    callback(error: error, responseData: nil)
        //                    break
        //                }
        //        }
    }
    
    
    static func userSearch(callback: responseCall, parameters: [String: AnyObject]?){
                Alamofire.request(.GET, serverDomain + "news/userSearch", parameters: parameters)
                    .validate()
                    .responseJSON { response in
        
                        switch response.result {
                        case .Success:
                            let JSON = response.result.value as! NSDictionary
                            callback(error:nil, responseData: JSON)
                            break
                        case .Failure(let error):
                            print(error)
                            callback(error: error, responseData: nil)
                            break
                        }
                }
    }
    
    
    static func login(callback: responseCall, parameters: [String: String]?){
        Alamofire.request(.POST, serverDomain + "news/login", parameters: parameters)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    let JSON = response.result.value as! NSDictionary
                    callback(error:nil, responseData: JSON)
                    break
                case .Failure(let error):
                    print(error)
                    callback(error: error, responseData: nil)
                    break
                }
        }
    }
    
    
    static func getNewsFeed(callback: responseCall, parameters: [String: String]?){
        Alamofire.request(.GET, serverDomain + "news/getNewsFeed", parameters: parameters)
            .validate()
            .responseJSON { response in
                
                print(response.request?.URLString)
                
                switch response.result {
                case .Success:
                    let JSON = response.result.value as! NSDictionary
                    callback(error:nil, responseData: JSON)
                    break
                case .Failure(let error):
                    print(error)
                    callback(error: error, responseData: nil)
                    break
                }
        }
    }
    
    
    static func getRecommandPersonList(callback: responseCall, parameters: [String: String]?){
        Alamofire.request(.GET, serverDomain + "news/getRecommandPersonList", parameters: parameters)
            .validate()
            .responseJSON { response in
                
                print(response.request?.URLString)
                
                switch response.result {
                case .Success:
                    let JSON = response.result.value as! NSDictionary
                    callback(error:nil, responseData: JSON)
                    break
                case .Failure(let error):
                    print(error)
                    callback(error: error, responseData: nil)
                    break
                }
        }
    }

}
