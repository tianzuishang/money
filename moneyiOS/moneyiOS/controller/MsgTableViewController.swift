//
//  MsgTableViewController.swift
//  moneyiOS
//
//  Created by wang jam on 8/10/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit

class MsgTableViewController: UITableViewController {

    
    var userlist = [UserModel]()
    var headlist = [UserModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "消息"
        titleLabel.font = UIFont(name: fontName, size: minMiddleFont)
        titleLabel.sizeToFit()
        
        self.navigationItem.titleView = titleLabel
        
        self.tableView.registerClass(MsgTableViewCell.self, forCellReuseIdentifier: "MsgTableViewCell");
        
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "搜索", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("searchButton"))
        
        
        
//        let rightbutton = UIButton.init(type: UIButtonType.Custom)
//        rightbutton.setBackgroundImage(UIImage(named: "magnifier.png"), forState: UIControlState.Normal)
//        rightbutton.frame = CGRectMake(0, 0, 24, 24)
//        rightbutton.tintColor = UIColor.whiteColor()
//        
//        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightbutton)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "magnifier_32px.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("searchButton"))
        
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
        
        
        let contact = UserModel()
        contact.name = "通讯录"
        contact.lastTalk = "查看我的通讯录"
        contact.contactflag = true
        headlist.append(contact)
    }
    
    func searchButton() {
        
        let searchPeople = SearchPeopleTableViewCtrl(style:UITableViewStyle.Grouped)
        searchPeople.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchPeople, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(section == 0){
            return headlist.count
        }else{
            return userlist.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MsgTableViewCell", forIndexPath: indexPath) as! MsgTableViewCell

        if(indexPath.section == 0){
            
            cell.configureCell(headlist[indexPath.row])
            
        }else{
            cell.configureCell(userlist[indexPath.row])
        }
        
        
        // Configure the cell...

        return cell
    }
    

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MsgTableViewCell.cellHeight()
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
