//
//  LiveModel.swift
//  moneyiOS
//
//  Created by wang jam on 9/4/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import EVReflection


class LiveModel: EVObject {
    var userModel = UserModel()
    var liveTitle: String!
    var startTimeStamp: Int!
    var participateCount: Int!
}
