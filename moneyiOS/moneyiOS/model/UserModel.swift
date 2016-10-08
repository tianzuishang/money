//
//  UserModel.swift
//  moneyiOS
//
//  Created by wang jam on 8/11/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
//import EVReflection


class UserModel: NSObject {
    var userSrno: Int = 0
    var userID: String?
    var userName: String?
    var faceImageName: String?
    var entySrno: Int = 0
    var entyName: String?
    var cityDesc: String?
    var prvnceDesc: String?
    var sign: String?
    var followCount: Int = 0
    var fansCount: Int = 0
    var deviceToken: String?
    
    
    
    func setModel(dic: NSDictionary) {
        userSrno = dic["userSrno"] as! Int
        userID = dic["userID"] as? String
        userName = dic["userName"] as? String
        faceImageName = dic["faceImageName"] as? String
        entySrno = dic["entySrno"] as! Int
        entyName = dic["entyName"] as? String
        cityDesc = dic["cityDesc"] as? String
        prvnceDesc = dic["prvnceDesc"] as? String
        sign = dic["sign"] as? String
        followCount = dic["followCount"] as! Int
        fansCount = dic["fansCount"] as! Int

    }
}
