//
//  MarketTableViewController.swift
//  moneyiOS
//
//  Created by wang jam on 8/7/16.
//  Copyright © 2016 jam wang. All rights reserved.
//  行情的tableviewcontroller



import UIKit

class MarketTableViewController: UITableViewController {

    var pullDownCall: apiCall?
    var pullUpCall: apiCall?
    
    var sectionTitles: [String]?
    var marketModels: [[MarketModel]]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.registerClass(MarketTableViewCell.self, forCellReuseIdentifier: "marketcell");

        
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.addTarget(self, action: "pullDownAction", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl!.tintColor = UIColor.grayColor();
        
        //self.tableView.separatorColor = UIColor.clearColor()
        
        
        sectionTitles = [String]()
        marketModels = [[MarketModel]]()
    }

    func pullDownAction() {
        if(pullDownCall != nil){
                pullDownCall!(callback: {(error: NSError? ,responseData: NSDictionary?) in
                
                self.refreshControl?.endRefreshing()
                
                if(error != nil){
                    print(error)
                }
                
                self.sectionTitles?.removeAll()
                self.marketModels?.removeAll()

                if(responseData != nil){
                    print(responseData)
                    
                    if(responseData!["code"] as! Int == 0){
                        
                        let tempDic = responseData!["data"] as! NSDictionary
                        
                        self.sectionTitles = tempDic["sectionTitles"] as? [String]
                        
                        let marketArray = tempDic["marketModels"] as! NSArray
                        
                        for item in marketArray {
                            var rowArray = [MarketModel]()
                            for model in item as! NSArray {
                                let marketmodel = MarketModel()
                                marketmodel.prdcTitle = model["prdcTitle"] as! String
                                marketmodel.price = model["price"] as? CGFloat
                                marketmodel.bp = model["bp"] as? CGFloat
                                marketmodel.prdcImageUrl = model["prdcImageUrl"] as? String
                                marketmodel.compareTitle = model["compareTitle"] as? String
                                rowArray.append(marketmodel)
                            }
                            self.marketModels?.append(rowArray)
                        }
                        
                        
                    }else{
                        print("code:%d", responseData!["code"])
                    }
                    
                }
                
                self.tableView.reloadData()
            })
            
        }else{
            
            self.refreshControl?.endRefreshing()
            
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 3*minSpace))
        sectionView.backgroundColor = UIColor.whiteColor()
        let sectionLabel = UILabel()
        sectionLabel.text = sectionTitles![section]
        sectionLabel.textColor = UIColor.grayColor()
        sectionLabel.font = UIFont(name: fontName, size: minFont)
        sectionLabel.sizeToFit()
        sectionView.addSubview(sectionLabel)
        sectionLabel.snp_updateConstraints { (make) -> Void in
            make.centerY.equalTo(sectionView.snp_centerY)
            make.left.equalTo(sectionView.snp_left).offset(2*minSpace)
        }
        return sectionView;
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles![section]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (marketModels?.count)!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return marketModels![section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("marketcell", forIndexPath: indexPath) as! MarketTableViewCell

        // Configure the cell...
        
        
        
        cell.configureCell(marketModels![indexPath.section][indexPath.row])
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(indexPath.section<marketModels!.count && indexPath.row<marketModels![indexPath.section].count){
            return MarketTableViewCell.cellHeight(marketModels![indexPath.section][indexPath.row])

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
