//
//  NewsModel.swift
//  UICollectionViewTest
//
//  Created by wang jam on 8/1/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import EVReflection

class NewsModel: EVObject {
    var title: String = ""
    var subTitle: String = ""
    var source: String = ""
    var publishTime: String = ""
    var titleImageUrl: String?
    var headline: Bool?
}
