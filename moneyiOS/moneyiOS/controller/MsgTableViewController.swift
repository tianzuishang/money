//
//  MsgTableViewController.swift
//  moneyiOS
//
//  Created by wang jam on 8/10/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class MsgTableViewController: UITableViewController {

    
    var userlist = [UserModel]()
    var headlist = [UserModel]()
    
    
    var msgList = [MsgModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        self.setTitle(title: "消息", active: false)
        
        
        self.tableView.register(MsgTableViewCell.self, forCellReuseIdentifier: "MsgTableViewCell");
        
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "搜索", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("searchButton"))
        
        
        
//        let rightbutton = UIButton.init(type: UIButtonType.Custom)
//        rightbutton.setBackgroundImage(UIImage(named: "magnifier.png"), forState: UIControlState.Normal)
//        rightbutton.frame = CGRectMake(0, 0, 24, 24)
//        rightbutton.tintColor = UIColor.whiteColor()
//        
//        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightbutton)
        
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "magnifier_32px.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("searchButton"))
        
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        
        
//        let contact = UserModel()
//        contact.userName = "通讯录"
//        contact.lastTalk = "查看我的通讯录"
//        contact.contactflag = true
//        headlist.append(contact)
        
        
        let msgModel = MsgModel()
        
        msgModel.lastTalk = "最后一条发送或接收的消息"
        
        msgModel.lastTimeStamp = 1473750467
        
        msgModel.userModel.userName = "外汇交易中心-谁谁谁"
        msgModel.userModel.faceImageName = "tempFace3.jpg"
        
        
        msgList.append(msgModel)
        msgList.append(msgModel)

        msgList.append(msgModel)

        msgList.append(msgModel)

        msgList.append(msgModel)

        msgList.append(msgModel)

        msgList.append(msgModel)

        msgList.append(msgModel)

        msgList.append(msgModel)

        msgList.append(msgModel)

        msgList.append(msgModel)

        
        
        NotificationCenter.default.addObserver(self, selector: #selector(MsgTableViewController.applicationWillEnterForeground(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let app = UIApplication.shared.delegate as! AppDelegate;
        
        if(app.socketAPI.isConnect() != socketConnected) {
            socketConnect()
        }else{
            
            getMissedMsg()
            
        }
        
    }
    
    
    
    func applicationWillEnterForeground(_ notification: NSNotification) {
        
        
        let app = UIApplication.shared.delegate as! AppDelegate;
        
        if(app.socketAPI.isConnect() != socketConnected) {
            socketConnect()
        }else{
            
            getMissedMsg()
            
        }
        
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        
        //NotificationCenter.default.removeObserver(self)
        
        //[[NSNotificationCenter defaultCenter] removeObserver:self];
        
    }
    
    
    
    func setTitle(title: String, active: Bool) {
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.text = title
        titleLabel.font = UIFont(name: fontName, size: 20)
        titleLabel.sizeToFit()
        
        self.navigationItem.titleView = titleLabel
        
        print(titleLabel.frame.size.width)
        
        if(active == true) {
            
            let activeLoad = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            
            activeLoad.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            activeLoad.center = CGPoint(x: (self.navigationItem.titleView?.center.x)! + titleLabel.frame.size.width/2 + 2*minSpace, y: (self.navigationItem.titleView?.center.y)!)
            activeLoad.hidesWhenStopped = true
            activeLoad.startAnimating()
            self.navigationItem.titleView?.addSubview(activeLoad)
            
        }
    }
    
    
    func getMissedMsg() {
        
        setTitle(title:"收取中", active: true)
        
        let app = UIApplication.shared.delegate as! AppDelegate;
        let data:[String: Any] = [
            "userID": app.myUserInfo!.userID!
        ]
        
        app.socketAPI.sendMsg(data: data, event: "missedMsg") { (ackData) in
            
            self.setTitle(title:"消息", active: false)
            
            let ackDataDic = ackData[0] as! NSDictionary
            
            if(ackDataDic.object(forKey: "code") as! Int == SUCCESS) {
                
                
                
            }else{
                
                print("离线消息收取失败")
                
            }
        }
        
        
    }
    
    
    func socketRegister() {
        
        let app = UIApplication.shared.delegate as! AppDelegate;

        
        let data:[String: Any] = [
            "userID": app.myUserInfo!.userID!
        ]
        
        
        app.socketAPI.sendMsg(data: data, event: "register") { (ackData) in
            
            let ackDataDic = ackData[0] as! NSDictionary
            
            if(ackDataDic.object(forKey: "code") as! Int == SUCCESS) {
                //登记成功
                print("登记成功")
                //获取离线信息
                self.getMissedMsg()
                
                
            }else{
                //登记不成功
                print("登记异常")
                
            }
            
        }
        
    }
    
    
    func socketConnect() {
        
        setTitle(title: "连接中", active: true)
        
        let app = UIApplication.shared.delegate as! AppDelegate;
        
        app.socketAPI.connectServer(connectCall: { (data) in
            
            print("连接成功")
            //注册
            self.socketRegister()
            
            
            
            }, disconnectCall: { (data) in
                
                self.setTitle(title: "断开连接", active: true)
                
                
            }, errorCall: { (data) in
                
                self.setTitle(title: "连接异常", active: true)
                
            }, reconnectCall: { (data) in
                
                self.setTitle(title: "正在重连", active: true)
                
            }, reconnectAttemptCall: { (data) in
                
                self.setTitle(title: "正在尝试重连", active: true)

        })

    }
    
    
    func searchButton() {
        
        let searchPeople = SearchPeopleTableViewCtrl(style:UITableViewStyle.grouped)
        searchPeople.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchPeople, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return msgList.count
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MsgTableViewCell", for: indexPath) as! MsgTableViewCell

        
        cell.configureCell(msgList[(indexPath as NSIndexPath).row])
        
        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let talkViewCtrl = TalkViewController()
        
        talkViewCtrl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(talkViewCtrl, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
