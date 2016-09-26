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
        seg.addTarget(self, action: #selector(MarketViewController.clickSegment(_:)), for: UIControlEvents.valueChanged)
        //seg.tintColor = UIColor.blueColor()
        //seg.tintColor = UIColor.clearColor()
        seg.tintColor = UIColor.white
        
        tradeTableViewCtrl.tableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        self.navigationItem.titleView = seg
        self.view.addSubview(tradeTableViewCtrl.view)
        self.view.addSubview(marketView!)
        self.view.bringSubview(toFront: marketView!)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationDidBecomeActive(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        
    }

    
    func applicationDidBecomeActive(_ notification: Notification) {
        table1.refreshControl?.endRefreshing()
        table2.refreshControl?.endRefreshing()
        table3.refreshControl?.endRefreshing()
        table4.refreshControl?.endRefreshing()
    }
    
    
    func initTradeView() {
        
    }
    
    
    func initMarketScrollView() {
        
        marketView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        marketView?.backgroundColor = backgroundColor
        
        marketSegControl = UISegmentedControl(items: ["基准", "外汇", "人民币", "曲线指数"])
        marketSegControl.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 24)
        marketSegControl.selectedSegmentIndex = 0
        marketSegControl.addTarget(self, action: #selector(MarketViewController.clickMarketSegment(_:)), for: UIControlEvents.valueChanged)
        marketSegControl.tintColor = UIColor.clear
        
        
        marketSegControl.setTitleTextAttributes([NSFontAttributeName: UIFont(name: fontName, size: minFont)!, NSForegroundColorAttributeName: UIColor.black], for: UIControlState.selected)
        
        marketSegControl.setTitleTextAttributes([NSFontAttributeName: UIFont(name: fontName, size: minFont)!, NSForegroundColorAttributeName: UIColor.gray], for: UIControlState())
        
        
        
        marketView!.addSubview(marketSegControl)
        
        marketScrollView = UIScrollView(frame: CGRect(x: 0, y: 24, width: ScreenWidth, height: ScreenHeight));
        marketScrollView.backgroundColor = backgroundColor
        marketScrollView.delegate = self
        marketScrollView.contentSize = CGSize(width: 4*self.view.frame.width, height: 0)
        marketScrollView.isPagingEnabled = true
        marketScrollView.showsHorizontalScrollIndicator = false
        
        
        table1.view.backgroundColor = backgroundColor
        table2.view.backgroundColor = backgroundColor
        table3.view.backgroundColor = backgroundColor
        table4.view.backgroundColor = backgroundColor
        
        table1.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64 - 49 - 24)
        table2.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64 - 49 - 24)
        table3.view.frame = CGRect(x: 2*self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64 - 49 - 24)
        table4.view.frame = CGRect(x: 3*self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64 - 49 - 24)
        
        
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
    
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        print(scrollView.contentOffset.x)
        
        if(scrollView == marketScrollView){
            let select = Int(scrollView.contentOffset.x/self.view.frame.width)
            self.marketSegControl.selectedSegmentIndex = select
        }
    }
    
    
    func clickMarketSegment(_ segment: UISegmentedControl) {
        print(segment.selectedSegmentIndex);
        
        switch segment.selectedSegmentIndex {
        case 0:
            marketScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            
            break
            
        case 1:
            marketScrollView.setContentOffset(CGPoint(x: self.view.frame.width, y: 0), animated: false)
            break
        case 2:
            marketScrollView.setContentOffset(CGPoint(x: 2*self.view.frame.width, y: 0), animated: false)
            break
        case 3:
            marketScrollView.setContentOffset(CGPoint(x: 3*self.view.frame.width, y: 0), animated: false)
            break
        default:
            break
        }
    }
    
    
    func clickSegment(_ segment: UISegmentedControl) {
        print(segment.selectedSegmentIndex);
        
        switch segment.selectedSegmentIndex {
        case 0:
            
            
            self.view.bringSubview(toFront: tradeTableViewCtrl.view!)
            
            break
            
        case 1:
            self.view.bringSubview(toFront: marketView!)
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
