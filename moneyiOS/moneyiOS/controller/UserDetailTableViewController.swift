//
//  UserDetailTableViewController.swift
//  moneyiOS
//
//  Created by wang jam on 8/12/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit


class UserDetailTableViewController: UITableViewController {

    var usermodel: UserModel?
    var sectionRowMap = [(title:String, value:String?)]();
    let addButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        self.tableView.registerClass(faceCell.self, forCellReuseIdentifier: "faceCell");
        
        
        
        initAddButton()
        
    }

    
    func addButtonAction(button: UIButton){
        print("addButtonAction")
        
        //self.navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate;
        let msgTableViewCtrl = app.msgTableViewCtrl
        
        msgTableViewCtrl.userlist.insert(usermodel!, atIndex: 0)
        msgTableViewCtrl.tableView.reloadData()
        
        self.navigationController?.popToRootViewControllerAnimated(true);
        
    }
    
    func initAddButton(){
        self.tableView.tableFooterView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 8*minSpace))
        
        addButton.frame = CGRectMake(2*minSpace, 0, ScreenWidth - 4*minSpace, 44)
        
        addButton.setTitle("添加到通讯录", forState: UIControlState.Normal)
        addButton.layer.cornerRadius = 5.0
        addButton.layer.masksToBounds = true
        addButton.showsTouchWhenHighlighted = true
        
        
        addButton.titleLabel?.textColor = UIColor.whiteColor()
        addButton.backgroundColor = themeColor
        addButton.addTarget(self, action: Selector("addButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.tableView.tableFooterView?.addSubview(addButton)
        
//        addButton.snp_makeConstraints { (make) -> Void in
//            make.width.equalTo(ScreenWidth - 4*minSpace)
//            make.height.equalTo(44)
//            make.left.equalTo((self.tableView.tableFooterView?.snp_left)!).offset(2*minSpace)
//            make.top.equalTo((self.tableView.tableFooterView?.snp_bottom)!).offset(minSpace)
//        }
    }
    
    func setUserModel(model: UserModel?){
        usermodel = model
        sectionRowMap = [
            (title: "机构", value: usermodel?.entyName),
            (title: "地区", value: usermodel?.prvnceDesc),
            (title: "城市", value: usermodel?.cityDesc),
            (title: "个人签名", value: usermodel?.sign)
        ]
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
            return 1
        }
        
        if(section == 1){
            return sectionRowMap.count
        }
        
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if(indexPath.section == 0 && indexPath.row == 0){
            
            let cell = tableView.dequeueReusableCellWithIdentifier("faceCell", forIndexPath: indexPath) as? faceCell
            
            cell?.configureCell(usermodel!)
            
            return cell!
            
        }else{
            
            //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
            
            cell.textLabel?.text = sectionRowMap[indexPath.row].title;
            cell.detailTextLabel?.text = sectionRowMap[indexPath.row].value;
            return cell
        }
        
        
        
        // Configure the cell...
        
        
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0 && indexPath.row == 0){
            return faceCell .cellHeight()
        }else{
            return 44
        }
    }
    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
