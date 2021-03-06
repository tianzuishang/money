//
//  NewsViewCtrl.swift
//  moneyiOS
//
//  Created by wang jam on 8/2/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit

class NewsViewCtrl: UIViewController, UIScrollViewDelegate {

    var scrollview = UIScrollView()
    var seg = UISegmentedControl()
    
    let table1 = NewsTableViewController()
    let table2 = NewsTableViewController()
    let table3 = NewsTableViewController()
    let table4 = NewsTableViewController()
    let newsApi = NewsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollview = UIScrollView(frame: self.view.frame);
        scrollview.backgroundColor = UIColor.blackColor()
        scrollview.delegate = self
        
        table1.view.backgroundColor = backgroundColor
        table2.view.backgroundColor = backgroundColor
        table3.view.backgroundColor = backgroundColor
        table4.view.backgroundColor = backgroundColor
        
        
        table1.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 64 - 49)
        table2.view.frame = CGRectMake(self.view.frame.width, 0, self.view.frame.width, self.view.frame.height - 64 - 49)
        table3.view.frame = CGRectMake(2*self.view.frame.width, 0, self.view.frame.width, self.view.frame.height - 64 - 49)
        table4.view.frame = CGRectMake(3*self.view.frame.width, 0, self.view.frame.width, self.view.frame.height - 64 - 49)
        
        
        table1.pullDownCall = NewsAPI.getHotNews
        table2.pullDownCall = NewsAPI.getAnnouncementList
        table3.pullDownCall = NewsAPI.getDepositlist
        table4.pullDownCall = NewsAPI.getPublishlist
        
        scrollview.addSubview(table1.tableView)
        scrollview.addSubview(table2.tableView)
        scrollview.addSubview(table3.tableView)
        scrollview.addSubview(table4.tableView)
        
        scrollview.contentSize = CGSizeMake(4*self.view.frame.width, 0)
        scrollview.pagingEnabled = true
        
        
        scrollview.showsHorizontalScrollIndicator = false
        
        
        seg = UISegmentedControl(items: ["热点",  "公告", "存单", "发行"])
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: "clickSegment:", forControlEvents: UIControlEvents.ValueChanged)
        seg.tintColor = UIColor.clearColor()
        
        
        seg.setTitleTextAttributes([NSFontAttributeName: UIFont(name: fontName, size: minMiddleFont)!, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Selected)
        
        seg.setTitleTextAttributes([NSFontAttributeName: UIFont(name: fontName, size: normalFont)!, NSForegroundColorAttributeName: UIColor.lightTextColor()], forState: UIControlState.Normal)
        
        self.navigationItem.titleView = seg
        self.view.addSubview(scrollview)
    }

    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        table1.refreshControl?.endRefreshing()
        table2.refreshControl?.endRefreshing()
        table3.refreshControl?.endRefreshing()
        table4.refreshControl?.endRefreshing()
        
        table1.viewWillAppear(true)
        table2.viewWillAppear(true)
        table3.viewWillAppear(true)
        table4.viewWillAppear(true)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        print(scrollview.contentOffset.x)
        
        
        
        let select = Int(scrollview.contentOffset.x/self.view.frame.width)
        seg.selectedSegmentIndex = select
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        
        
        
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        print("scrollViewDidEndScrollingAnimation")
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(scrollview.isKindOfClass(UITableView.self)){
            print("tableview scroll")
        }else{
            print("scroll view scroll")
        }
    }
    
    func clickSegment(segment: UISegmentedControl) {
        print(segment.selectedSegmentIndex);
        
        switch segment.selectedSegmentIndex {
        case 0:
            scrollview.setContentOffset(CGPointMake(0, 0), animated: false)
            
            break
            
        case 1:
            scrollview.setContentOffset(CGPointMake(self.view.frame.width, 0), animated: false)
            break
        case 2:
            scrollview.setContentOffset(CGPointMake(2*self.view.frame.width, 0), animated: false)
            break
        case 3:
            scrollview.setContentOffset(CGPointMake(3*self.view.frame.width, 0), animated: false)
            break
        default:
            break
        }
        
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
