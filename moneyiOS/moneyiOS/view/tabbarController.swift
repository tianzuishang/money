//
//  TabbarController.swift
//  wxListSample
//
//  Created by wang jam on 7/20/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit


struct tabItem {
    var title: String
    var iconName: String
    var viewCtrl: UIViewController
}

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
                
        //let tabArray = [nav1, otherViewCtrl];
        
        //self.viewControllers = tabArray;
    }
    
    func tabInit(_ items: [tabItem]) {
        
        var tabArray = [UIViewController]();
        
        
        for (index, item) in items.enumerated()  {
            
            let tabbarItem = UITabBarItem(title: item.title, image: UIImage(named: item.iconName), tag: index);
            item.viewCtrl.tabBarItem = tabbarItem;
            
            tabArray.append(item.viewCtrl);
            
        }
        
        self.viewControllers = tabArray;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
