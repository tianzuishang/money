//
//  NewsAPI.swift
//  moneyiOS
//
//  Created by wang jam on 8/2/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import Alamofire

typealias responseCall = (_ error: NSError? ,_ responseData: NSDictionary?)->Void
typealias apiCall = (_ callback: @escaping responseCall) ->Void

class NewsAPI: NSObject {
    
    static let serverDomain = ConfigAccess.serverDomain()
    
    
    static func httpRequestForGet(url: String, parameters: [String: AnyObject]?, callback: @escaping responseCall) {
        
        Alamofire.request(url, method: .get, parameters: parameters).validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    let JSON = response.result.value as! NSDictionary
                    callback(nil, JSON)
                    break
                case .failure(let error):
                    print(error)
                    callback(error as NSError?, nil)
                    break
                }
        }
        
    }
    
    
    static func httpRequestForPost(url: String, parameters: [String: AnyObject]?, callback: @escaping responseCall) {
        
        Alamofire.request(url, method: .post, parameters: parameters).validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    let JSON = response.result.value as! NSDictionary
                    callback(nil, JSON)
                    break
                case .failure(let error):
                    print(error)
                    callback(error as NSError?, nil)
                    break
                }
        }
        
    }
    
    
    static func getHotNews(_ callback: @escaping responseCall){
        NewsAPI.httpRequestForGet(url: serverDomain + "news/hotNewslist", parameters: nil, callback: callback)
    }
    
    static func getAnnouncementList(_ callback: @escaping responseCall){
        
        
        NewsAPI.httpRequestForGet(url: serverDomain + "news/announcementList", parameters: nil, callback: callback)
    }
    
    static func getDepositlist(_ callback: @escaping responseCall){
        
        NewsAPI.httpRequestForGet(url: serverDomain + "news/depositlist", parameters: nil, callback: callback)
    }
    
    
    static func getPublishlist(_ callback: @escaping responseCall){
        
        NewsAPI.httpRequestForGet(url: serverDomain + "news/publishlist", parameters: nil, callback: callback)
        
    }
    
    static func getBenchmark(_ callback: @escaping responseCall){
        
        
        NewsAPI.httpRequestForGet(url: serverDomain + "news/getBenchmark", parameters: nil, callback: callback)

    }
    
    
    static func getForeign(_ callback: @escaping responseCall){
        
        
        NewsAPI.httpRequestForGet(url: serverDomain + "news/getForeign", parameters: nil, callback: callback)

    }
    
    static func getRMB(_ callback: @escaping responseCall){
        
        NewsAPI.httpRequestForGet(url: serverDomain + "news/getRMB", parameters: nil, callback: callback)
    }
    
    static func getCurve(_ callback: responseCall){
        //        Alamofire.request(.GET, serverDomain + "news/publishlist", parameters: nil)
        //            .validate()
        //            .responseJSON { response in
        //
        //                switch response.result {
        //                case .success:
        //                    let JSON = response.result.value as! NSDictionary
        //                    callback(error:nil, responseData: JSON)
        //                    break
        //                case .failure(let error):
        //                    print(error)
        //                    callback(error: error, responseData: nil)
        //                    break
        //                }
        //        }
    }
    
    
    static func userSearch(_ callback: @escaping responseCall, parameters: [String: AnyObject]?){
        
        
        NewsAPI.httpRequestForGet(url: serverDomain + "news/userSearch", parameters: parameters, callback: callback)
    }
    
    
    static func login(_ callback: @escaping responseCall, parameters: [String: AnyObject]?){
        
        NewsAPI.httpRequestForPost(url: serverDomain + "news/login", parameters: parameters, callback: callback)
    }
    
    
    static func getNewsFeed(_ callback: @escaping responseCall, parameters: [String: AnyObject]?){
        
        NewsAPI.httpRequestForGet(url: serverDomain + "news/getNewsFeed", parameters: parameters, callback: callback)

    }
    
    
    static func getRecommandPersonList(_ callback: @escaping responseCall, parameters: [String: AnyObject]?){
        
        NewsAPI.httpRequestForGet(url: serverDomain + "news/getRecommandPersonList", parameters: parameters, callback: callback)
    }
    
    
    static func getUserDetail(_ callback: @escaping responseCall, parameters: [String: AnyObject]?){
        
        NewsAPI.httpRequestForGet(url: serverDomain + "news/getUserDetail", parameters: parameters, callback: callback)
    }
    

}
