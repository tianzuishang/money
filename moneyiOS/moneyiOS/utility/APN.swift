//
//  APN.swift
//  moneyiOS
//
//  Created by wang jam on 06/10/2016.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit

class APN: NSObject {

    static func initAPNNotification() {
        let setting = UIUserNotificationSettings(types: [UIUserNotificationType.badge, UIUserNotificationType.alert,UIUserNotificationType.sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(setting)
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    
    
    
    
}
