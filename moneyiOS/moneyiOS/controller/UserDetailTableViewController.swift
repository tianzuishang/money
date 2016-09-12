//
//  UserDetailTableViewController.swift
//  moneyiOS
//
//  Created by wang jam on 8/12/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit
import BXProgressHUD

class UserDetailTableViewController: UITableViewController {

    var usermodel: UserModel?
    var sectionRowMap = [(title:String, value:String?)]();
    let addButton: UIButton = UIButton()
    
    static let faceWidth = 14*minSpace
    static let headViewHeight = 48*minSpace
    
    
    let sectionMap = (
        faceSection: 0,
        newFriendSection: 1,
        newsSection: 2,
        detailSection: 3,
        contactSection: 4,
        quitSection: 5
    )
    
    
    let newFriendSectionTitles = ["新的好友"]
    let newsSectionTitles = ["最近动态"]
    let detailSectionTitles = ["机构", "地区"]
    let contactSectionTitles = ["微信", "微博", "QQ"]
    let quitSectionTitles = ["退出当前账号"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell");
        self.tableView.registerClass(faceCell.self, forCellReuseIdentifier: "faceCell");
        
        
        
        //initAddButton()
        
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "pullDownAction", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl!.tintColor = UIColor.grayColor();
        self.pullDownAction()
        
    }
    
    
    func initHeadView() {
        
        let view = UIView(frame: CGRectMake(0, 0, ScreenWidth, UserDetailTableViewController.headViewHeight))
        //view.backgroundColor = themeColor
        
        let blurEffect = UIBlurEffect(style: .Light)
        let backView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(backView)
        
        backView.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(view.snp_left)
            make.top.equalTo(view.snp_top)
            make.right.equalTo(view.snp_right)
            make.height.equalTo(UserDetailTableViewController.headViewHeight/2)
        }
        
        UIImageView().kf_setImageWithURL(NSURL(string: ConfigAccess.serverDomain()+(usermodel?.faceImageName)!)!, placeholderImage: nil, optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
            
            if(image == nil){
                return
            }
            
            backView.backgroundColor = UIColor(patternImage: image!)
            
        })

        
        
        
        let faceView = UIImageView()
        faceView.clipsToBounds = true
        faceView.layer.cornerRadius = UserDetailTableViewController.faceWidth/2
        faceView.contentMode = UIViewContentMode.ScaleAspectFill
        
        view.addSubview(faceView)
        
        faceView.snp_makeConstraints { (make) -> Void in
            make.size.width.equalTo(UserDetailTableViewController.faceWidth)
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(backView.snp_bottom).offset(UserDetailTableViewController.faceWidth/2)
        }
        
        Tool.setFaceViewImage(faceView, faceViewWidth: UserDetailTableViewController.faceWidth, imageUrl: ConfigAccess.serverDomain()+(usermodel?.faceImageName)!)
        
        self.tableView.tableHeaderView = view
    }
    
    func initNavTitle(title: String){
        let navTitle = UILabel()
        navTitle.textColor = UIColor.whiteColor()
        navTitle.text = title
        navTitle.sizeToFit()
        navTitle.textAlignment = NSTextAlignment.Center
        navTitle.font = UIFont(name: fontName, size: 20)
        self.navigationItem.titleView = navTitle

    }
    
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.5
    }
    
    
    func pullDownAction() {
        NewsAPI.getUserDetail({ (error, responseData) -> Void in
            self.refreshControl?.endRefreshing()
            
            if(error != nil){
                BXProgressHUD.Builder(forView: self.view).text("\(error?.code):"+(error?.localizedFailureReason)!).mode(.Text).show().hide(afterDelay: 2)

            }else{
                
                if(responseData!["code"] as! Int == SUCCESS){
                    
                    let userDetail = UserModel(dictionary: responseData!["data"]!["userDetail"] as! NSDictionary)
                    
                    self.usermodel = userDetail
                    
                    //self.initNavTitle(self.usermodel!.userName!)
                    
                    //self.initHeadView()
                    
                }else{
                    
                    Tool.showErrorMsgBox(responseData!["code"] as? Int)
                }
                
                self.tableView.reloadData()
            }
            
            
            
            }, parameters: ["userSrno": (usermodel?.userSrno) as! AnyObject])
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
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 6
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
//        if(section == 0){
//            return 0
//        }
//        
//        if(section == 1){
//            return 0
//            return sectionRowMap.count
//        }
        
        
        if(section == sectionMap.faceSection) {
            return 1
        }
        
        if(section == sectionMap.newFriendSection) {
            return newFriendSectionTitles.count
        }
        
        if(section == sectionMap.newsSection) {
            return newsSectionTitles.count
        }
        
        if(section == sectionMap.detailSection) {
            return detailSectionTitles.count
        }
        
        if(section == sectionMap.contactSection) {
            return contactSectionTitles.count
        }
        
        if(section == sectionMap.quitSection) {
            return quitSectionTitles.count
        }
        
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if(indexPath.section == 0 && indexPath.row == 0){
            
            let cell = tableView.dequeueReusableCellWithIdentifier("faceCell", forIndexPath: indexPath) as? faceCell
            
            cell?.configureCell(usermodel!)
            
            return cell!
            
        }else{
            
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")

            if(indexPath.section == sectionMap.newFriendSection){
                
                
                cell.textLabel?.text = newFriendSectionTitles[indexPath.row]
                
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                
            }
            
            if(indexPath.section == sectionMap.newsSection){
                
                cell.textLabel?.text = newsSectionTitles[indexPath.row]
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                
            }
            
            if(indexPath.section == sectionMap.detailSection){
                cell.textLabel?.text = detailSectionTitles[indexPath.row]
                
                if(indexPath.row == 0){
                    //机构
                    cell.detailTextLabel?.text = usermodel?.entyName
                }
                
                if(indexPath.row == 1){
                    //地区
                    if(usermodel?.cityDesc == nil||usermodel?.cityDesc == nil){
                        cell.detailTextLabel?.text = "未知"

                    }else{
                        cell.detailTextLabel?.text = (usermodel?.prvnceDesc)! + (usermodel?.cityDesc)!
                    }
                }

            }
            
            if(indexPath.section == sectionMap.contactSection){
                cell.textLabel?.text = contactSectionTitles[indexPath.row]
                cell.detailTextLabel?.text = "未绑定"
                
            }
            
            if(indexPath.section == sectionMap.quitSection){
                cell.textLabel?.text = quitSectionTitles[indexPath.row]

            }
            
            return cell
            
        }
        
        
        
        // Configure the cell...
        return UITableViewCell()
        
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
