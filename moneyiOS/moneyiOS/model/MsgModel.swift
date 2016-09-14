//
//  MsgModel.swift
//  moneyiOS
//
//  Created by wang jam on 9/13/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import EVReflection


class MsgModel: EVObject {
    
    var userModel: UserModel = UserModel()
    var lastTalk: String = ""
    var lastTimeStamp: Int = 0
    var unreadCount: Int = 0
    
}
