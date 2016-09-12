//
//  NewsFeedViewCtrl.swift
//  moneyiOS
//
//  Created by wang jam on 9/4/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import BXProgressHUD


class NewsFeedViewCtrl: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    let tableview = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49 - 44 - 20), style: UITableViewStyle.Grouped)
    
    
    
    let myInfo = (UIApplication.sharedApplication().delegate as! AppDelegate).myUserInfo
    
    
    var hotNewsArray = NSMutableArray()
    var liveArray = NSMutableArray()
    var followNewsArray = NSMutableArray()
    
    
    let refreshControl = UIRefreshControl()
    
    let sectionMap = (
        faceheadView: 0,
        hotNews: 1,
        lives: 2,
        follows: 3
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = grayBackgroundColor
        
                
        //self.view.addSubview(headview)
        
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = grayBackgroundColor
        tableview.separatorInset = UIEdgeInsetsMake(0,0, 0,0);
        
        self.view.addSubview(tableview)
        
        
        // Do any additional setup after loading the view.
        
        tableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell");
        
        tableview.registerClass(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell");
        tableview.registerClass(HeadLineTableViewCell.self, forCellReuseIdentifier: "HeadLineTableViewCell");
        
        tableview.registerClass(MoreTableViewCell.self, forCellReuseIdentifier: "MoreTableViewCell")
        
        tableview.registerClass(HeadFaceTableViewCell.self, forCellReuseIdentifier: "HeadFaceTableViewCell")
        
        tableview.registerClass(LiveTableViewCell.self, forCellReuseIdentifier: "LiveTableViewCell")

        
        tableview.registerClass(NewsFeedTableViewCell.self, forCellReuseIdentifier: "NewsFeedTableViewCell")

        
        
        
        refreshControl.addTarget(self, action: "pullDownAction", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.tintColor = UIColor.grayColor();
        
        tableview.addSubview(refreshControl)
        
        
        //tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.pullDownAction()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("applicationDidBecomeActive:"), name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        
        let navTitle = UILabel()
        navTitle.textColor = UIColor.whiteColor()
        navTitle.text = "动态"
        navTitle.sizeToFit()
        navTitle.textAlignment = NSTextAlignment.Center
        navTitle.font = UIFont(name: fontName, size: 20)
        self.navigationItem.titleView = navTitle
    }

    
    func applicationDidBecomeActive(notification: NSNotification) {
        self.refreshControl.endRefreshing()
    }

    
    
    override func viewDidDisappear(animated: Bool) {
        self.refreshControl.endRefreshing()
    }
    
    func pullDownAction() {
        
        NewsAPI.getNewsFeed({ (error, responseData) -> Void in
            
            self.hotNewsArray.removeAllObjects()
            self.liveArray.removeAllObjects()
            self.refreshControl.endRefreshing()
            
            if(error != nil){
                BXProgressHUD.Builder(forView: self.view).text("\(error?.code):"+(error?.localizedFailureReason)!).mode(.Text).show().hide(afterDelay: 2)
            }else {
                
                if(responseData!["code"] as! Int == ERROR) {
                    
                    BXProgressHUD.Builder(forView: self.view).text("后台出错").mode(.Text).show().hide(afterDelay: 2)
                }
                
                
                if(responseData!["code"] as! Int == SUCCESS) {
                    
                    var tempArray = responseData!["data"]!["hotNewslist"] as! NSArray
                    
                    self.hotNewsArray.addObject("今日热点")
                    
                    
                    
                    for item in tempArray {
                        let newsmodel = NewsModel()
                        newsmodel.title = item["title"] as! String
                        newsmodel.subTitle = item["subTitle"] as! String
                        newsmodel.publishTime = item["publishTime"] as! String
                        newsmodel.source = item["source"] as! String
                        newsmodel.titleImageUrl = item["titleImageUrl"] as? String
                        newsmodel.headline = item["headline"] as? Bool
                        self.hotNewsArray.addObject(newsmodel)
                    }
                    self.hotNewsArray.addObject("更多")
                    
                    
                    //直播
                    tempArray = responseData!["data"]!["liveList"] as! NSArray
                    
                    for item in tempArray {
                        let livemodel = LiveModel()
                        livemodel.userModel.userName = item["name"] as? String
                        livemodel.userModel.faceImageName = item["faceImageName"] as? String
                        livemodel.liveTitle = item["liveTitle"] as! String
                        livemodel.startTimeStamp = item["startTimeStamp"] as! Int
                        self.liveArray.addObject(livemodel)
                    }
                    
                    
                    //动态信息
                    tempArray = responseData!["data"]!["followList"] as! NSArray
                    
                    for item in tempArray {
                        let newsFeedModel = NewsFeedModel()
                        newsFeedModel.userModel.userName = item["name"] as? String
                        newsFeedModel.userModel.faceImageName = item["faceImageName"] as? String
                        newsFeedModel.entyDesc = item["entyDesc"] as? String
                        newsFeedModel.headTitle = item["headTitle"] as? String
                        newsFeedModel.publishTimestamp = item["publishTimeStamp"] as! Int
                        newsFeedModel.content = item["content"] as? String
                        newsFeedModel.contentImageUrl = item["contentImageUrl"] as? String
                        newsFeedModel.commentCount = item["commentCount"] as! Int
                        newsFeedModel.likeCount = item["likeCount"] as! Int
                        
                        self.followNewsArray.addObject(newsFeedModel)
                    }

                }
                
            }
            
            self.tableview.reloadData()
            
            }, parameters: nil)
        
    }
    
    func getFollowNews() {
        
    }
    
    func getLives() {
        
    }
    
    func getHotNews() {
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //布局
        
        
        
//        tableview.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(headview.snp_bottom).offset(minSpace)
//            make.left.equalTo(self.view.snp_left)
//        }
    }
    
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if(section == 0){
//            
//            return MoreTableViewCell.cellHeight()
//        }else{
//            return 32
//        }
        return 12
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if(section == 0){
//            return HeadLineTableViewCell.cellHeight()
//        }else{
//            return 32
//        }
        return 0.5
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let view = UIView(frame: CGRectMake(0, 0, ScreenWidth, 4*minSpace))
//        view.backgroundColor = grayBackgroundColor
//        return view
//
//        
////        if(section == 0){
////            let cellView = HeadLineTableViewCell()
////            cellView.configureCell("今日热点")
////            return cellView
////        }else{
////            
////            
////            
////        }
//    }
    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
////        if(section == 0){
////            let cellView = MoreTableViewCell()
////            return cellView
////        }else{
////            return nil
////        }
//        return nil
//    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(indexPath.section == sectionMap.hotNews){
            
            if(indexPath.row > self.hotNewsArray.count){
                return 0
            }
            
            if(indexPath.row == 0){
                
                return HeadLineTableViewCell.cellHeight()
                
            }else if(indexPath.row == self.hotNewsArray.count - 1){
                return MoreTableViewCell.cellHeight()
            }else{
                
                return NewsTableViewCell.cellHeight(self.hotNewsArray[indexPath.row] as! NewsModel)
            }
        }
        
        if(indexPath.section == sectionMap.faceheadView){
            return HeadFaceTableViewCell.cellHeight()
        }
        
        if(indexPath.section == sectionMap.lives) {
            return LiveTableViewCell.cellHeight()
        }
        
        if(indexPath.section == sectionMap.follows) {
            
            return NewsFeedTableViewCell.cellHeight(self.followNewsArray.objectAtIndex(indexPath.row) as! NewsFeedModel)
        }
        
        return 44
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == sectionMap.faceheadView ){
            return 1
        }
        
        if(section == sectionMap.hotNews ){
            //热点
            return self.hotNewsArray.count
        }
        
        else if(section == sectionMap.lives ){
            //live
            return 1
        }
        
        else if(section == sectionMap.follows ){
            //follow的动态
            
            return self.followNewsArray.count
        }else{
            return 0
        }
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if(indexPath.section == sectionMap.hotNews){
            //新闻
            
            if(self.hotNewsArray[indexPath.row] is String){
                if(indexPath.row == 0){
                    let cell = tableView.dequeueReusableCellWithIdentifier("HeadLineTableViewCell", forIndexPath: indexPath) as! HeadLineTableViewCell
                    
                    
                    // Configure the cell...
                    
                    cell.configureCell(self.hotNewsArray[indexPath.row] as! String)
                    
                    return cell

                }else{
                    //更多
                    
                    let cell = tableView.dequeueReusableCellWithIdentifier("MoreTableViewCell", forIndexPath: indexPath) as! MoreTableViewCell
                    
                    
                    // Configure the cell...
                    
                    cell.configureCell(self.hotNewsArray[indexPath.row] as! String)
                    
                    return cell

                }
                
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("NewsTableViewCell", forIndexPath: indexPath) as! NewsTableViewCell
                
                
                // Configure the cell...
                
                cell.configureCell(self.hotNewsArray[indexPath.row] as! NewsModel)
                
                return cell
            }
            
        }
        
        if(indexPath.section == sectionMap.lives){
            //直播
            let cell = tableView.dequeueReusableCellWithIdentifier("LiveTableViewCell", forIndexPath: indexPath) as! LiveTableViewCell
            
            cell.configureCell(liveArray)
            
            // Configure the cell...
            
            return cell
        }
        
        
        if(indexPath.section == sectionMap.faceheadView){
            
            let cell = tableView.dequeueReusableCellWithIdentifier("HeadFaceTableViewCell", forIndexPath: indexPath) as! HeadFaceTableViewCell
            
            
            
            cell.configureCell(myInfo!)
            
            // Configure the cell...
            
            return cell
            
        }
        
        
        if(indexPath.section == sectionMap.follows) {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("NewsFeedTableViewCell", forIndexPath: indexPath) as! NewsFeedTableViewCell
            
            cell.configureCell(self.followNewsArray.objectAtIndex(indexPath.row) as! NewsFeedModel)
            
            // Configure the cell...
            
            return cell
        }
        
        return UITableViewCell()
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
