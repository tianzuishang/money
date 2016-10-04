//
//  UserDetailTableViewController.swift
//  moneyiOS
//
//  Created by wang jam on 8/12/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit
//import BXProgressHUD

class UserDetailTableViewController: UITableViewController {

    var usermodel: UserModel?
    var sectionRowMap = [(title:String, value:String?)]();
    let addButton: UIButton = UIButton()
    
    static let faceWidth = 14*minSpace
    static let headViewHeight = 38*minSpace
    
    
    let sectionMap = (
        newFriendSection: 0,
        detailSection: 1,
        contactSection: 2,
        quitSection: 3
    )
    
    
    let newFriendSectionTitles = ["最近动态", "关注的人", "被关注的人"]
    let detailSectionTitles = ["机构", "地区"]
    let contactSectionTitles = ["微信", "微博", "QQ"]
    let quitSectionTitles = ["退出当前账号"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell");
        self.tableView.register(faceCell.self, forCellReuseIdentifier: "faceCell");
        
        
        
        //initAddButton()
        
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(UserDetailTableViewController.pullDownAction), for: UIControlEvents.valueChanged)
        self.refreshControl!.tintColor = UIColor.gray;
        self.pullDownAction()
        
    }
    
    
    func initHeadView() {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: UserDetailTableViewController.headViewHeight))
        
        view.backgroundColor = UIColor.white
        //view.backgroundColor = themeColor
        
        let blurEffect = UIBlurEffect(style: .light)
        let backView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(backView)
        
        backView.snp.makeConstraints { (make) -> Void in
            
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(UserDetailTableViewController.headViewHeight/2)
        }
        
        UIImageView().kf.setImage(with: URL(string: ConfigAccess.serverDomain()+(usermodel?.faceImageName)!)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cachetype, nil) in
            
            
            if(image == nil){
                return
            }
            
            backView.backgroundColor = UIColor(patternImage: image!)

        }
        
        
        
        let faceView = UIImageView()
        faceView.clipsToBounds = true
        faceView.layer.cornerRadius = UserDetailTableViewController.faceWidth/2
        faceView.contentMode = UIViewContentMode.scaleAspectFill
        
        view.addSubview(faceView)
        
        faceView.snp.makeConstraints { (make) -> Void in
            make.size.width.equalTo(UserDetailTableViewController.faceWidth)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(backView.snp.bottom).offset(UserDetailTableViewController.faceWidth/2)
        }
        
        Tool.setFaceViewImage(faceView, faceViewWidth: UserDetailTableViewController.faceWidth, imageUrl: ConfigAccess.serverDomain()+(usermodel?.faceImageName)!)
        
        
        let nameLabel = UILabel()
        nameLabel.text = usermodel?.userName
        nameLabel.font = UIFont(name: fontName, size: minMiddleFont)
        
        
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(faceView.snp.bottom).offset(minSpace)
            make.centerX.equalTo(faceView.snp.centerX)
            
        }
        
        let entyLabel = UILabel()
        entyLabel.text = usermodel?.entyName
        entyLabel.font = UIFont(name: fontName, size: normalFont)
        
        view.addSubview(entyLabel)
        
        entyLabel.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(nameLabel.snp.bottom).offset(minSpace)
            make.centerX.equalTo(nameLabel.snp.centerX)
        }
        
        let signLabel = UILabel()
        signLabel.text = usermodel?.sign
        signLabel.font = UIFont(name: fontName, size: normalFont)
        
        view.addSubview(signLabel)
        
        signLabel.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(entyLabel.snp.bottom).offset(minSpace)
            make.centerX.equalTo(nameLabel.snp.centerX)
            
        }
        
        
        
        
        self.tableView.tableHeaderView = view
    }
    
    func initNavTitle(_ title: String){
        let navTitle = UILabel()
        navTitle.textColor = UIColor.white
        navTitle.text = title
        navTitle.sizeToFit()
        navTitle.textAlignment = NSTextAlignment.center
        navTitle.font = UIFont(name: fontName, size: 20)
        self.navigationItem.titleView = navTitle

    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 12
    }
    
    
    func pullDownAction() {
        NewsAPI.getUserDetail({ (error, responseData) -> Void in
            self.refreshControl?.endRefreshing()
            
            if(error != nil){
//                BXProgressHUD.Builder(forView: self.view).text("\(error?.code):"+(error?.localizedFailureReason)!).mode(.text).show().hide(afterDelay: 2)

            }else{
                
                if(responseData!["code"] as! Int == SUCCESS){
                    
                    let data = responseData!["data"] as! NSDictionary
                    
                    let userDic = data["userDetail"] as! NSDictionary
                    
                    let userDetail = UserModel()
                    userDetail.setModel(dic: userDic)
                    
                    
                    
                    
                    
                    self.usermodel = userDetail
                    
                    self.initNavTitle(self.usermodel!.userName!)
                    
                    self.initHeadView()
                    
                }else{
                    
                    Tool.showErrorMsgBox(responseData!["code"] as? Int)
                }
                
                self.tableView.reloadData()
            }
            
            
            
            }, parameters: ["userSrno": (usermodel?.userSrno) as AnyObject])
    }
    
    
    func addButtonAction(_ button: UIButton){
        print("addButtonAction")
        
        //self.navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        
        
        let app = UIApplication.shared.delegate as! AppDelegate;
        let msgTableViewCtrl = app.msgTableViewCtrl
        
        msgTableViewCtrl.userlist.insert(usermodel!, at: 0)
        msgTableViewCtrl.tableView.reloadData()
        
        self.navigationController?.popToRootViewController(animated: true);
        
    }
    
    func initAddButton(){
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 8*minSpace))
        
        addButton.frame = CGRect(x: 2*minSpace, y: 0, width: ScreenWidth - 4*minSpace, height: 44)
        
        addButton.setTitle("添加到通讯录", for: UIControlState())
        addButton.layer.cornerRadius = 5.0
        addButton.layer.masksToBounds = true
        addButton.showsTouchWhenHighlighted = true
        
        
        addButton.titleLabel?.textColor = UIColor.white
        addButton.backgroundColor = themeColor
        addButton.addTarget(self, action: #selector(UserDetailTableViewController.addButtonAction(_:)), for: UIControlEvents.touchUpInside)
        self.tableView.tableFooterView?.addSubview(addButton)
        
//        addButton.snp.makeConstraints { (make) -> Void in
//            make.width.equalTo(ScreenWidth - 4*minSpace)
//            make.height.equalTo(44)
//            make.left.equalTo((self.tableView.tableFooterView?.snp.left)!).offset(2*minSpace)
//            make.top.equalTo((self.tableView.tableFooterView?.snp.bottom)!).offset(minSpace)
//        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
//        if(section == 0){
//            return 0
//        }
//        
//        if(section == 1){
//            return 0
//            return sectionRowMap.count
//        }
        
        
        if(section == sectionMap.newFriendSection) {
            return newFriendSectionTitles.count
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")

        if((indexPath as NSIndexPath).section == sectionMap.newFriendSection){
            
            
            cell.textLabel?.text = newFriendSectionTitles[(indexPath as NSIndexPath).row]
            
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
            //cell.imageView?.image = UIImage(named: "Person_add_72px.png")
            
            if((indexPath as NSIndexPath).row == 1){
                //关注的人
                cell.detailTextLabel?.text = "231"
            }
            
            if((indexPath as NSIndexPath).row == 2){
                //被关注的人
                cell.detailTextLabel?.text = "1238"
            }
            
        }
        
        
        if((indexPath as NSIndexPath).section == sectionMap.detailSection){
            cell.textLabel?.text = detailSectionTitles[(indexPath as NSIndexPath).row]
            
            if((indexPath as NSIndexPath).row == 0){
                //机构
                cell.detailTextLabel?.text = usermodel?.entyName
            }
            
            if((indexPath as NSIndexPath).row == 1){
                //地区
                if(usermodel?.cityDesc == nil||usermodel?.cityDesc == nil){
                    cell.detailTextLabel?.text = "未知"

                }else{
                    cell.detailTextLabel?.text = (usermodel?.prvnceDesc)! + (usermodel?.cityDesc)!
                }
            }

        }
        
        if((indexPath as NSIndexPath).section == sectionMap.contactSection){
            cell.textLabel?.text = contactSectionTitles[(indexPath as NSIndexPath).row]
            cell.detailTextLabel?.text = "未绑定"
            
        }
        
        if((indexPath as NSIndexPath).section == sectionMap.quitSection){
            cell.textLabel?.text = quitSectionTitles[(indexPath as NSIndexPath).row]

        }
        
        return cell
        
        
        
        // Configure the cell...
        
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 44
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
