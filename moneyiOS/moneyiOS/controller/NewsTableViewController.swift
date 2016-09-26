//
//  NewsTableViewController.swift
//  moneyiOS
//
//  Created by wang jam on 8/2/16.
//  Copyright © 2016 jam wang. All rights reserved.
//  新闻的tableviewcontroller

import UIKit
import Kingfisher


class NewsTableViewController: UITableViewController {

    var newsArray: [NewsModel] = []
    var headlineArray: [NewsModel] = []
    var pullDownCall: apiCall?
    var pullUpCall: apiCall?
    var headlineScrollView: UIScrollView?
    var pageControl: UIPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newscell");
        
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView.sectionFooterHeight = 5
        
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.addTarget(self, action: #selector(NewsTableViewController.pullDownAction), for: UIControlEvents.valueChanged)
        self.refreshControl!.tintColor = UIColor.gray;
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.pullDownAction()
    }
    
    
    func pullDownAction() {
        if(pullDownCall != nil){
            newsArray.removeAll()
            headlineArray.removeAll()
            pullDownCall!({(error: NSError? ,responseData: NSDictionary?) in
                
                self.refreshControl?.endRefreshing()
                
                if(error != nil){
                    print(error)
                }
                
                if(responseData != nil){
                    print(responseData)
                    
                    if(responseData!["code"] as! Int == 0){
                        
                        let tempArray = responseData!["data"] as! NSArray
                        
                        for item in tempArray {
                            let itemDic = item as! NSDictionary
                            
                            let newsmodel = NewsModel()
                            newsmodel.title = itemDic["title"] as! String
                            newsmodel.subTitle = itemDic["subTitle"] as! String
                            newsmodel.publishTime = itemDic["publishTime"] as! String
                            newsmodel.source = itemDic["source"] as! String
                            newsmodel.titleImageUrl = itemDic["titleImageUrl"] as? String
                            newsmodel.headline = itemDic["headline"] as? Bool
                            if(newsmodel.headline == true){
                                self.headlineArray.append(newsmodel)
                            }else{
                                self.newsArray.append(newsmodel)
                            }
                        }
                        
                        
                    }else{
                        print("code:%d", responseData!["code"])
                    }
                    
                }
                
                if(self.headlineArray.count != 0){
                    
                    
                    self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth*0.5))
                    self.headlineScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth*0.5))
                    self.tableView.tableHeaderView?.addSubview(self.headlineScrollView!)
                    
                    self.setHeadline()
                    
                }else{
                    self.headlineScrollView?.removeFromSuperview()
                    self.tableView.tableHeaderView?.removeFromSuperview()
                    
                    
                    
                    self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 0.1))
                    
                    //self.headlineScrollView = nil
                }
                
                self.tableView.reloadData()
            })
            
        }else{
            
            self.refreshControl?.endRefreshing()
            
        }
    }
    
    
    func setHeadline() {
        
        
        
        self.headlineScrollView!.delegate = self
        
        
        
        for i in 0 ..< headlineArray.count {
            let imageview = UIImageView(frame: CGRect(x: CGFloat(Float(i))*self.headlineScrollView!.frame.width, y: 0, width: self.headlineScrollView!.frame.width, height: self.headlineScrollView!.frame.height))
            self.headlineScrollView!.addSubview(imageview)
            
            
            Tool.setViewImage(imageView: imageview, imageUrl: ConfigAccess.serverDomain()+headlineArray[i].titleImageUrl!)
            
            imageview.contentMode = UIViewContentMode.scaleAspectFill
            imageview.clipsToBounds = true
            
//            let uiview = UIView()
//            uiview.snp_makeConstraints(closure: { (make) -> Void in
//                <#code#>
//            })
//            
//            uiview.backgroundColor = UIColor.grayColor()
//            uiview.alpha = 0.5
//            imageview.addSubview(uiview)
            
            let titlelabel = UILabel()
            imageview.addSubview(titlelabel)
            titlelabel.snp_makeConstraints({ (make) -> Void in
                make.width.equalTo(imageview.frame.width - 4*minSpace)
                make.height.equalTo(imageview.frame.width*0.1)
                make.left.equalTo(imageview.snp_left).offset(2*minSpace)
                make.bottom.equalTo(imageview.snp_bottom).offset(-2*minSpace)
            })
            
            //titlelabel.backgroundColor = UIColor.grayColor()
            
            titlelabel.textAlignment = NSTextAlignment.center
            titlelabel.font = UIFont(name: fontName, size: minMiddleFont)
            titlelabel.textColor = UIColor.white
            titlelabel.text = headlineArray[i].title
            
            
            
        }
        
        self.pageControl = UIPageControl()
        self.pageControl!.numberOfPages = headlineArray.count
        self.pageControl!.currentPage = 0
        if(headlineArray.count == 1){
            self.pageControl?.isHidden = true
        }
        self.tableView.tableHeaderView?.addSubview(self.pageControl!)
        self.pageControl!.snp_makeConstraints { (make) -> Void in
            make.width.equalTo((self.tableView.tableHeaderView?.snp_width)!)
            make.height.equalTo(minSpace)
            make.centerX.equalTo((self.tableView.tableHeaderView?.snp_centerX)!)
            make.bottom.equalTo((self.tableView.tableHeaderView?.snp_bottom)!).offset(-minSpace)
        }
        
        self.headlineScrollView!.isPagingEnabled = true
        self.headlineScrollView!.contentSize = CGSize(width: CGFloat(Float(headlineArray.count))*self.headlineScrollView!.frame.width, height: 0)
    }
    
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if(scrollView == self.headlineScrollView){
            print("scrollViewDidEndDecelerating")
            print(scrollView.contentOffset.x)
            let select = Int(scrollView.contentOffset.x/self.tableView.frame.width)
            pageControl?.currentPage = select
        }
    }

    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
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
        return newsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newscell", for: indexPath) as! NewsTableViewCell
        
        // Configure the cell...
        
        cell.configureCell(newsArray[(indexPath as NSIndexPath).row])
        
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        // Configure the cell...
        //cell.textLabel?.text = "测试"
        
        return cell

    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if((indexPath as NSIndexPath).row < newsArray.count){
            return NewsTableViewCell.cellHeight(newsArray[(indexPath as NSIndexPath).row])
        }else{
            return 0
        }
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
