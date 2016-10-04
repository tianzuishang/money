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
//import BXProgressHUD


class NewsFeedViewCtrl: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    let tableview = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 49 - 44 - 20), style: UITableViewStyle.grouped)
    
    
    
    let myInfo = (UIApplication.shared.delegate as! AppDelegate).myUserInfo
    
    
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
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell");
        
        tableview.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell");
        tableview.register(HeadLineTableViewCell.self, forCellReuseIdentifier: "HeadLineTableViewCell");
        
        tableview.register(MoreTableViewCell.self, forCellReuseIdentifier: "MoreTableViewCell")
        
        tableview.register(HeadFaceTableViewCell.self, forCellReuseIdentifier: "HeadFaceTableViewCell")
        
        tableview.register(LiveTableViewCell.self, forCellReuseIdentifier: "LiveTableViewCell")

        
        tableview.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: "NewsFeedTableViewCell")

        
        
        
        refreshControl.addTarget(self, action: #selector(NewsFeedViewCtrl.pullDownAction), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.gray;
        
        tableview.addSubview(refreshControl)
        
        
        //tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.pullDownAction()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationDidBecomeActive(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        
        let navTitle = UILabel()
        navTitle.textColor = UIColor.white
        navTitle.text = "动态"
        navTitle.sizeToFit()
        navTitle.textAlignment = NSTextAlignment.center
        navTitle.font = UIFont(name: fontName, size: 20)
        self.navigationItem.titleView = navTitle
    }

    
    func applicationDidBecomeActive(_ notification: Notification) {
        self.refreshControl.endRefreshing()
    }

    
    
    override func viewDidDisappear(_ animated: Bool) {
        self.refreshControl.endRefreshing()
    }
    
    func pullDownAction() {
        
        NewsAPI.getNewsFeed({ (error, responseData) -> Void in
            
            self.hotNewsArray.removeAllObjects()
            self.liveArray.removeAllObjects()
            self.refreshControl.endRefreshing()
            
            if(error != nil){
//                BXProgressHUD.Builder(forView: self.view).text("\(error?.code):"+(error?.localizedFailureReason)!).mode(.text).show().hide(afterDelay: 2)
            }else {
                
                if(responseData!["code"] as! Int == ERROR) {
                    
//                    BXProgressHUD.Builder(forView: self.view).text("后台出错").mode(.text).show().hide(afterDelay: 2)
                }
                
                
                if(responseData!["code"] as! Int == SUCCESS) {
                    
                    let data = responseData!["data"] as! NSDictionary
                    
                    var tempArray = data["hotNewslist"] as! NSArray
                    
                    self.hotNewsArray.add("今日热点")
                    
                    
                    
                    for item in tempArray {
                        let itemDic = item as! NSDictionary
                        let newsmodel = NewsModel()
                        newsmodel.title = itemDic["title"] as! String
                        newsmodel.subTitle = itemDic["subTitle"] as! String
                        newsmodel.publishTime = itemDic["publishTime"] as! String
                        newsmodel.source = itemDic["source"] as! String
                        newsmodel.titleImageUrl = itemDic["titleImageUrl"] as? String
                        newsmodel.headline = itemDic["headline"] as? Bool
                        self.hotNewsArray.add(newsmodel)
                    }
                    self.hotNewsArray.add("更多")
                    
                    
                    //直播
                    tempArray = data["liveList"] as! NSArray
                    
                    for item in tempArray {
                        let itemDic = item as! NSDictionary
                        
                        let livemodel = LiveModel()
                        livemodel.userModel.userName = itemDic["name"] as? String
                        livemodel.userModel.faceImageName = itemDic["faceImageName"] as? String
                        livemodel.liveTitle = itemDic["liveTitle"] as! String
                        livemodel.startTimeStamp = itemDic["startTimeStamp"] as! Int
                        self.liveArray.add(livemodel)
                    }
                    
                    
                    //动态信息
                    tempArray = data["followList"] as! NSArray
                    
                    for item in tempArray {
                        
                        let itemDic = item as! NSDictionary
                        
                        let newsFeedModel = NewsFeedModel()
                        newsFeedModel.userModel.userName = itemDic["name"] as? String
                        newsFeedModel.userModel.faceImageName = itemDic["faceImageName"] as? String
                        newsFeedModel.entyDesc = itemDic["entyDesc"] as? String
                        newsFeedModel.headTitle = itemDic["headTitle"] as? String
                        newsFeedModel.publishTimestamp = itemDic["publishTimeStamp"] as! Int
                        newsFeedModel.content = itemDic["content"] as? String
                        newsFeedModel.contentImageUrl = itemDic["contentImageUrl"] as? String
                        newsFeedModel.commentCount = itemDic["commentCount"] as! Int
                        newsFeedModel.likeCount = itemDic["likeCount"] as! Int
                        
                        self.followNewsArray.add(newsFeedModel)
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
    
    override func viewWillAppear(_ animated: Bool) {
        //布局
        
        
        
//        tableview.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(headview.snp.bottom).offset(minSpace)
//            make.left.equalTo(self.view.snp.left)
//        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if(indexPath.section == 0 && indexPath.row == 0){
//            print("click head face")
//        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if(section == 0){
//            
//            return MoreTableViewCell.cellHeight()
//        }else{
//            return 32
//        }
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if((indexPath as NSIndexPath).section == sectionMap.hotNews){
            
            if((indexPath as NSIndexPath).row > self.hotNewsArray.count){
                return 0
            }
            
            if((indexPath as NSIndexPath).row == 0){
                
                return HeadLineTableViewCell.cellHeight()
                
            }else if((indexPath as NSIndexPath).row == self.hotNewsArray.count - 1){
                return MoreTableViewCell.cellHeight()
            }else{
                
                return NewsTableViewCell.cellHeight(self.hotNewsArray[(indexPath as NSIndexPath).row] as! NewsModel)
            }
        }
        
        if((indexPath as NSIndexPath).section == sectionMap.faceheadView){
            return HeadFaceTableViewCell.cellHeight()
        }
        
        if((indexPath as NSIndexPath).section == sectionMap.lives) {
            return LiveTableViewCell.cellHeight()
        }
        
        if((indexPath as NSIndexPath).section == sectionMap.follows) {
            
            return NewsFeedTableViewCell.cellHeight(self.followNewsArray.object(at: (indexPath as NSIndexPath).row) as! NewsFeedModel)
        }
        
        return 44
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if((indexPath as NSIndexPath).section == sectionMap.hotNews){
            //新闻
            
            if(self.hotNewsArray[(indexPath as NSIndexPath).row] is String){
                if((indexPath as NSIndexPath).row == 0){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HeadLineTableViewCell", for: indexPath) as! HeadLineTableViewCell
                    
                    
                    // Configure the cell...
                    
                    cell.configureCell(self.hotNewsArray[(indexPath as NSIndexPath).row] as! String)
                    
                    return cell

                }else{
                    //更多
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
                    
                    
                    // Configure the cell...
                    
                    cell.configureCell(self.hotNewsArray[(indexPath as NSIndexPath).row] as! String)
                    
                    return cell

                }
                
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
                
                
                // Configure the cell...
                
                cell.configureCell(self.hotNewsArray[(indexPath as NSIndexPath).row] as! NewsModel)
                
                return cell
            }
            
        }
        
        if((indexPath as NSIndexPath).section == sectionMap.lives){
            //直播
            let cell = tableView.dequeueReusableCell(withIdentifier: "LiveTableViewCell", for: indexPath) as! LiveTableViewCell
            
            cell.configureCell(liveArray)
            
            // Configure the cell...
            
            return cell
        }
        
        
        if((indexPath as NSIndexPath).section == sectionMap.faceheadView){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeadFaceTableViewCell", for: indexPath) as! HeadFaceTableViewCell
            
            
            
            cell.configureCell(myInfo!)
            
            // Configure the cell...
            
            return cell
            
        }
        
        
        if((indexPath as NSIndexPath).section == sectionMap.follows) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell", for: indexPath) as! NewsFeedTableViewCell
            
            cell.configureCell(self.followNewsArray.object(at: (indexPath as NSIndexPath).row) as! NewsFeedModel)
            
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
