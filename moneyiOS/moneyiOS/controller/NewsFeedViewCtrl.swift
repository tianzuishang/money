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

    let tableview = UITableView(frame: CGRectMake(0, 9*minSpace, ScreenWidth, ScreenHeight - 9*minSpace))
    let headview = UIView()
    let faceView = UIImageView()
    let headLabel = UILabel()
    let headIcon = UIImageView()
    let myInfo = (UIApplication.sharedApplication().delegate as! AppDelegate).myUserInfo
    
    
    var hotNewsArray = NSMutableArray()
    var liveArray = NSMutableArray()
    var followNewsArray = NSMutableArray()
    
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = grayBackgroundColor
        
        headLabel.text = "分享我的照片或动态"
        headLabel.textColor = UIColor.grayColor()
        headLabel.font = UIFont(name: fontName, size: minFont)
        headLabel.sizeToFit()
        
        
        faceView.clipsToBounds = true
        faceView.contentMode = UIViewContentMode.ScaleAspectFit
        faceView.layer.cornerRadius = 6*minSpace/2
        
        if(myInfo?.faceImageName != nil){
            faceView.kf_setImageWithURL(NSURL(string: ConfigAccess.serverDomain()+myInfo!.faceImageName!)!, placeholderImage: UIImage(named: "man-noname.png"))
        }else{
            faceView.image = UIImage(named: "man-noname.png")
        }
        
        
        headIcon.image = UIImage(named: "camera_.png")
        headIcon.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        
        
        headview.backgroundColor = UIColor.whiteColor()
        headview.addSubview(faceView)
        headview.addSubview(headLabel)
        headview.addSubview(headIcon)
        
        self.view.addSubview(headview)
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tableview)
        
        
        // Do any additional setup after loading the view.
        
        tableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell");
        
        tableview.registerClass(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell");
        
        
        refreshControl.addTarget(self, action: "pullDownAction", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.tintColor = UIColor.grayColor();
        
        tableview.addSubview(refreshControl)
        
        self.pullDownAction()
    }

    
    func pullDownAction() {
        
        NewsAPI.getNewsFeed({ (error, responseData) -> Void in
            
            self.hotNewsArray.removeAllObjects()
            self.refreshControl.endRefreshing()
            
            if(error != nil){
                BXProgressHUD.Builder(forView: self.view).text("\(error?.code):"+(error?.localizedFailureReason)!).mode(.Text).show().hide(afterDelay: 2)
            }else {
                
                if(responseData!["code"] as! Int == ERROR) {
                    
                    BXProgressHUD.Builder(forView: self.view).text("后台出错").mode(.Text).show().hide(afterDelay: 2)
                }
                
                
                if(responseData!["code"] as! Int == SUCCESS) {
                    
                    let tempArray = responseData!["data"]!["hotNewslist"] as! NSArray
                    
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
        
        headview.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.snp_width)
            make.height.equalTo(8*minSpace)
            make.top.equalTo(self.view.snp_top)
            make.left.equalTo(self.view.snp_left)
        }
        
        faceView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(headview.snp_left).offset(2*minSpace)
            make.centerY.equalTo(headview.snp_centerY)
            make.size.width.equalTo(6*minSpace)
        }
        
        headLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(faceView.snp_right).offset(minSpace)
            make.centerY.equalTo(faceView.snp_centerY)
        }
        
        headIcon.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(headview.snp_right).offset(-2*minSpace)
            make.centerY.equalTo(faceView.snp_centerY)
            make.size.width.equalTo(4*minSpace)
        }
        
        
//        tableview.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(headview.snp_bottom).offset(minSpace)
//            make.left.equalTo(self.view.snp_left)
//        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(indexPath.section == 0){
            return NewsTableViewCell.cellHeight(self.hotNewsArray[indexPath.row] as! NewsModel)
        }else{
            return 44
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            //热点
            return self.hotNewsArray.count
        }
        
        else if(section == 1){
            //live
            return 1
        }
        
        else if(section == 2){
            //follow的动态
            
            return self.followNewsArray.count
        }else{
            return 0
        }
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if(indexPath.section == 0){
            //新闻
            
            let cell = tableView.dequeueReusableCellWithIdentifier("NewsTableViewCell", forIndexPath: indexPath) as! NewsTableViewCell
            
            
            // Configure the cell...
            
            cell.configureCell(self.hotNewsArray[indexPath.row] as! NewsModel)
            
            return cell
            
        }
        
        if(indexPath.section == 1){
            //直播
            let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
            
            
            // Configure the cell...
            
            return cell
        }
        
        if(indexPath.section == 2){
            //follows动态
            
            let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
            
            
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
