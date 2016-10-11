//
//  AppDelegate.swift
//  moneyiOS
//
//  Created by wang jam on 7/18/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import CoreData
//import Bugly

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var msgTableViewCtrl: MsgTableViewController = MsgTableViewController()

    var myUserInfo: UserModel?
    
    var tabbar: TabbarController?
    
    var myLaunchOptions: [UIApplicationLaunchOptionsKey: Any]?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.window = UIWindow(frame: UIScreen.main.bounds);
        
        
        self.window?.rootViewController = tabInit();
        self.window?.makeKeyAndVisible();
        self.window!.backgroundColor = backgroundColor
        
        

        
        if(UserDefaults.standard.object(forKey: "userID") != nil
            && UserDefaults.standard.object(forKey: "userPassword") != nil){
                //直接登录
                let signinViewCtrl = signInView()
                signinViewCtrl.view.isHidden = true
                signinViewCtrl.login(UserDefaults.standard.object(forKey: "userID") as? String, password: UserDefaults.standard.object(forKey: "userPassword") as? String)
                
        }else{
            self.signInView()
        }
        
        
        Bugly.start(withAppId: "87e6825c9b")
        
        
        
        
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        //注册远程通知
        
        
        print("didFinishLaunchingWithOptions")
        
        
        //应用启动后，launchOptions为空则从图标进入,launchOptions不为空则从推送信息进入
        myLaunchOptions = launchOptions
        
        return true
    }

    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
//        if notificationSettings.types != UIUserNotificationType() {
//            application.registerForRemoteNotifications()
//        }
        
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("didFailToRegisterForRemoteNotificationsWithError:" + error.localizedDescription)
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        print("didReceiveRemoteNotification")
        
        
        //应用在后台，点击推送消息进入此函数
        
//        print(userInfo["tab"] as! Int)
//        
//        self.tabbar?.selectedViewController = self.tabbar?.viewControllers?[userInfo["tab"] as! Int]
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        if(myUserInfo != nil && myUserInfo?.userSrno != 0){
            
            let post = [
                "userSrno" : myUserInfo?.userSrno as AnyObject,
                "userDeviceToken" : deviceToken as AnyObject
            ]
            
            NewsAPI.updateUserDeviceToken({ (error, dictionary) in
                
                if(error != nil){
                    
                }else{
                    
                    let code = dictionary?["code"] as! Int
                    if(code != SUCCESS){
                        
                        Tool.showErrorMsgBox(code)
                        
                    }
                }
                
                
                }, parameters: post)
            
        }
        
    }
    
    
    
//    func traceLog() {
//        
//        let installation = KSCrashInstallationStandard.sharedInstance()
//        installation.url = NSURL(string: "https://collector.bughd.com/kscrash?key=55a7676422c31ece61b80af6244796f9")
//        installation.install()
//        installation.sendAllReportsWithCompletion()
//        
////        KSCrashInstallationStandard* installation = [KSCrashInstallationStandard sharedInstance];
////        installation.url = [NSURL URLWithString:@"https://collector.bughd.com/kscrash?key=55a7676422c31ece61b80af6244796f9"];
////        [installation install];
////        [installation sendAllReportsWithCompletion:nil];
//    }
    
    
    func tabInit() -> TabbarController {
        let nav1 = UINavigationController(rootViewController: NewsFeedViewCtrl())
        let nav2 = UINavigationController(rootViewController: FindTableViewController())
        
        let nav3 = UINavigationController(rootViewController: MarketViewController())
        let nav4 = UINavigationController(rootViewController: MsgTableViewController())
        
        
        
        
        
        let userDetailTableViewCtrl = UserDetailTableViewController(style:UITableViewStyle.grouped)
        
        
        userDetailTableViewCtrl.usermodel = myUserInfo
        let nav5 = UINavigationController(rootViewController: userDetailTableViewCtrl)
        
        
        
        nav1.navigationBar.barTintColor = themeColor
        //nav1.navigationBar.barStyle = UIStatusBarStyle.default
        nav2.navigationBar.barTintColor = themeColor
        nav3.navigationBar.barTintColor = themeColor
        nav4.navigationBar.barTintColor = themeColor
        nav4.navigationBar.tintColor = UIColor.white
        nav5.navigationBar.barTintColor = themeColor
        
        //self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
        //[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        
        nav1.navigationBar.isTranslucent = false
        nav2.navigationBar.isTranslucent = false
        nav3.navigationBar.isTranslucent = false
        nav4.navigationBar.isTranslucent = false
        nav5.navigationBar.isTranslucent = false
        
        
        let item1 = tabItem(title: "动态", iconName: "newsFeed.png", viewCtrl: nav1)
        let item2 = tabItem(title: "发现", iconName: "watch.png", viewCtrl: nav2);
        let item3 = tabItem(title: "市场", iconName: "market.png", viewCtrl: nav3)
        let item4 = tabItem(title: "消息", iconName: "message.png", viewCtrl: nav4)
        let item5 = tabItem(title: "我", iconName: "me.png", viewCtrl: nav5)
        
        
        let items = [item1, item2, item3, item4, item5];
        tabbar = TabbarController();
        tabbar?.tabInit(items)
        //tab.tabBar.barTintColor = themeColor
        tabbar?.tabBar.isTranslucent = false
        tabbar?.tabBar.tintColor = themeColor;
        return (tabbar)!
    }
    
    
    func signInView() -> SignInViewController {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default

        let signinViewCtrl = SignInViewController()
        self.window?.rootViewController = signinViewCtrl;
        
        return signinViewCtrl
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        UIApplication.shared.applicationIconBadgeNumber = 0;
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.jam.moneyiOS" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "moneyiOS", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

