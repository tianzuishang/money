//
//  FindTableViewController.swift
//  moneyiOS
//
//  Created by wang jam on 9/9/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import BXProgressHUD

class FindTableViewController: UITableViewController, UISearchBarDelegate {

    
    let personArray = NSMutableArray()
    let searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.registerClass(FindTableViewCell.self, forCellReuseIdentifier: "FindTableViewCell");
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "pullDownAction", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl!.tintColor = UIColor.grayColor();
        
        
        self.pullDownAction()
        
        
        searchBar.frame = CGRectMake(0, 0, ScreenWidth, 3*minSpace)
        searchBar.placeholder = "搜索用户或机构"
        //searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.whiteColor()
        searchBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.addSubview(searchBar)
        
        
        searchBar.snp_makeConstraints { (make) -> Void in
            
            make.centerY.equalTo((self.navigationController?.navigationBar.snp_centerY)!)
            make.left.equalTo((self.navigationController?.navigationBar.snp_left)!).offset(2*minSpace)
            make.right.equalTo((self.navigationController?.navigationBar.snp_right)!).offset(-2*minSpace)
            
        }
        
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
    }
    
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        searchBar.showsCancelButton = false
        
        return true
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        
        
        searchBar.showsCancelButton = true
        
        
        return true
        
    }
    
    
    func pullDownAction() {
        
        NewsAPI.getRecommandPersonList({ (error, responseData) -> Void in
            
            self.personArray.removeAllObjects()
            self.refreshControl?.endRefreshing()
            if(error != nil){
                BXProgressHUD.Builder(forView: self.view).text("\(error?.code):"+(error?.localizedFailureReason)!).mode(.Text).show().hide(afterDelay: 2)
            }else{
                
                if(responseData!["code"] as! Int == ERROR) {
                    
                    BXProgressHUD.Builder(forView: self.view).text("后台出错").mode(.Text).show().hide(afterDelay: 2)
                }
                
                if(responseData!["code"] as! Int == SUCCESS) {
                    
                    let tempArray = responseData!["data"]!["recommandPersonList"] as! NSArray
                    
                    for item in tempArray {
                        
                        let usermodel = UserModel()
                        usermodel.name = item["name"] as? String
                        usermodel.faceImageName = item["faceImageName"] as? String
                        usermodel.entyName = item["entyDesc"] as? String
                        
                        self.personArray.addObject(usermodel)
                        
                    }
                    
                    
                }
                
                
            }
            
            self.tableView.reloadData()
            
            
            
            }, parameters: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personArray.count
    }

    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 0){
            
            
            let view = UIView(frame: CGRectMake(0, 0, ScreenWidth, 4*minSpace))
            view.backgroundColor = UIColor.whiteColor()
            
            let label = UILabel()
            view.addSubview(label)
            
            label.text = "你可能感兴趣的人"
            label.font = UIFont(name: fontName, size: minFont)
            label.textColor = UIColor.grayColor()
            
            label.snp_makeConstraints(closure: { (make) -> Void in
                
                make.left.equalTo(view.snp_left).offset(2*minSpace)
                make.centerY.equalTo(view.snp_centerY)
            })
            
            return view
        }else{
            return UIView()
        }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section == 0){
            return "你可能感兴趣的人"
        }else{
            return ""
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FindTableViewCell", forIndexPath: indexPath) as! FindTableViewCell

        // Configure the cell...
        
        cell.configureCell(personArray.objectAtIndex(indexPath.row) as! UserModel)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return FindTableViewCell.cellHeight()
        
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
