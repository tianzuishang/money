//
//  MarketViewController.swift
//  moneyiOS
//
//  Created by wang jam on 8/7/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController, UIScrollViewDelegate {

    var seg = UISegmentedControl()
    
    let table1 = MarketTableViewController()
    let table2 = MarketTableViewController()
    let table3 = MarketTableViewController()
    let table4 = MarketTableViewController()
    
    let tradeTableViewCtrl = TradeTableViewController()
    
    let newsApi = NewsAPI()
    
    var marketScrollView = UIScrollView()
    var marketView: UIView?
    var marketSegControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        initMarketScrollView()
        
        
        
        
        seg = UISegmentedControl(items: ["交易", "行情"])
        seg.selectedSegmentIndex = 1
        seg.addTarget(self, action: "clickSegment:", forControlEvents: UIControlEvents.ValueChanged)
        //seg.tintColor = UIColor.blueColor()
        //seg.tintColor = UIColor.clearColor()
        seg.tintColor = UIColor.whiteColor()
        
        tradeTableViewCtrl.tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight)
        self.navigationItem.titleView = seg
        self.view.addSubview(tradeTableViewCtrl.view)
        self.view.addSubview(marketView!)
        self.view.bringSubviewToFront(marketView!)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("applicationDidBecomeActive:"), name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        
    }

    
    func applicationDidBecomeActive(notification: NSNotification) {
        table1.refreshControl?.endRefreshing()
        table2.refreshControl?.endRefreshing()
        table3.refreshControl?.endRefreshing()
        table4.refreshControl?.endRefreshing()
    }
    
    
    func initTradeView() {
        
    }
    
    
    func initMarketScrollView() {
        
        marketView = UIView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        marketView?.backgroundColor = backgroundColor
        
        marketSegControl = UISegmentedControl(items: ["基准", "外汇", "人民币", "曲线指数"])
        marketSegControl.frame = CGRectMake(0, 0, ScreenWidth, 24)
        marketSegControl.selectedSegmentIndex = 0
        marketSegControl.addTarget(self, action: "clickMarketSegment:", forControlEvents: UIControlEvents.ValueChanged)
        marketSegControl.tintColor = UIColor.clearColor()
        
        
        marketSegControl.setTitleTextAttributes([NSFontAttributeName: UIFont(name: fontName, size: minFont)!, NSForegroundColorAttributeName: UIColor.blackColor()], forState: UIControlState.Selected)
        
        marketSegControl.setTitleTextAttributes([NSFontAttributeName: UIFont(name: fontName, size: minFont)!, NSForegroundColorAttributeName: UIColor.grayColor()], forState: UIControlState.Normal)
        
        
        
        marketView!.addSubview(marketSegControl)
        
        marketScrollView = UIScrollView(frame: CGRectMake(0, 24, ScreenWidth, ScreenHeight));
        marketScrollView.backgroundColor = backgroundColor
        marketScrollView.delegate = self
        marketScrollView.contentSize = CGSizeMake(4*self.view.frame.width, 0)
        marketScrollView.pagingEnabled = true
        marketScrollView.showsHorizontalScrollIndicator = false
        
        
        table1.view.backgroundColor = backgroundColor
        table2.view.backgroundColor = backgroundColor
        table3.view.backgroundColor = backgroundColor
        table4.view.backgroundColor = backgroundColor
        
        table1.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 64 - 49 - 24)
        table2.view.frame = CGRectMake(self.view.frame.width, 0, self.view.frame.width, self.view.frame.height - 64 - 49 - 24)
        table3.view.frame = CGRectMake(2*self.view.frame.width, 0, self.view.frame.width, self.view.frame.height - 64 - 49 - 24)
        table4.view.frame = CGRectMake(3*self.view.frame.width, 0, self.view.frame.width, self.view.frame.height - 64 - 49 - 24)
        
        
        table1.pullDownCall = NewsAPI.getBenchmark
        table2.pullDownCall = NewsAPI.getForeign
        table3.pullDownCall = NewsAPI.getRMB
        table4.pullDownCall = NewsAPI.getCurve
        
        
        marketScrollView.addSubview(table1.tableView)
        marketScrollView.addSubview(table2.tableView)
        marketScrollView.addSubview(table3.tableView)
        marketScrollView.addSubview(table4.tableView)
        
        marketView?.addSubview(marketScrollView)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        table1.refreshControl?.endRefreshing()
        table2.refreshControl?.endRefreshing()
        table3.refreshControl?.endRefreshing()
        table4.refreshControl?.endRefreshing()
        
        table1.pullDownAction()
        table2.pullDownAction()
        table3.pullDownAction()
        table4.pullDownAction()
    }
    
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        print(scrollView.contentOffset.x)
        
        if(scrollView == marketScrollView){
            let select = Int(scrollView.contentOffset.x/self.view.frame.width)
            self.marketSegControl.selectedSegmentIndex = select
        }
    }
    
    
    func clickMarketSegment(segment: UISegmentedControl) {
        print(segment.selectedSegmentIndex);
        
        switch segment.selectedSegmentIndex {
        case 0:
            marketScrollView.setContentOffset(CGPointMake(0, 0), animated: false)
            
            break
            
        case 1:
            marketScrollView.setContentOffset(CGPointMake(self.view.frame.width, 0), animated: false)
            break
        case 2:
            marketScrollView.setContentOffset(CGPointMake(2*self.view.frame.width, 0), animated: false)
            break
        case 3:
            marketScrollView.setContentOffset(CGPointMake(3*self.view.frame.width, 0), animated: false)
            break
        default:
            break
        }
    }
    
    
    func clickSegment(segment: UISegmentedControl) {
        print(segment.selectedSegmentIndex);
        
        switch segment.selectedSegmentIndex {
        case 0:
            
            
            self.view.bringSubviewToFront(tradeTableViewCtrl.view!)
            
            break
            
        case 1:
            self.view.bringSubviewToFront(marketView!)
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
