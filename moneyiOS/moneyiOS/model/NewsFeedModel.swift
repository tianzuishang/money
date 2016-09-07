//
//  NewsFeedModel.swift
//  moneyiOS
//
//  Created by wang jam on 9/7/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit


//发布的动态
class NewsFeedModel: NSObject {
    var userModel = UserModel()
    var content: String?
    var contentImageUrl: String?
    var commentCount: Int = 0
    var likeCount: Int = 0
    var entyDesc: String?
    var headTitle: String?
    var publishTimestamp: Int = 0
}
