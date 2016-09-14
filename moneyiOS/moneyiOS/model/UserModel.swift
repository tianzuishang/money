//
//  UserModel.swift
//  moneyiOS
//
//  Created by wang jam on 8/11/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import EVReflection


class UserModel: EVObject {
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
}
