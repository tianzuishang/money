//
//  FindTableViewController.swift
//  moneyiOS
//
//  Created by wang jam on 9/9/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
//import BXProgressHUD

class FindTableViewController: UITableViewController, UISearchBarDelegate {

    
    let personArray = NSMutableArray()
    let searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.register(FindTableViewCell.self, forCellReuseIdentifier: "FindTableViewCell");
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(FindTableViewController.pullDownAction), for: UIControlEvents.valueChanged)
        self.refreshControl!.tintColor = UIColor.gray;
        
        
        self.pullDownAction()
        
        
        searchBar.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 3*minSpace)
        searchBar.placeholder = "搜索用户或机构"
        //searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.white
        searchBar.tintColor = UIColor.white
        
        
        //searchBar.setSearchFieldBackgroundImage(Tool.getImageWithColor(UIColor.lightGrayColor(), height: 4*minSpace), forState: UIControlState.Normal)
        
        self.navigationController?.navigationBar.addSubview(searchBar)
        
        
        
        
        searchBar.snp.makeConstraints { (make) -> Void in
            
            make.centerY.equalTo((self.navigationController?.navigationBar.snp.centerY)!)
            make.left.equalTo((self.navigationController?.navigationBar.snp.left)!).offset(2*minSpace)
            make.right.equalTo((self.navigationController?.navigationBar.snp.right)!).offset(-2*minSpace)
            
        }
        
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
    }
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        searchBar.showsCancelButton = false
        
        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        
        searchBar.showsCancelButton = true
        
        
        return true
        
    }
    
    
    func pullDownAction() {
        
        NewsAPI.getRecommandPersonList({ (error, responseData) -> Void in
            
            self.personArray.removeAllObjects()
            self.refreshControl?.endRefreshing()
            if(error != nil){
//                BXProgressHUD.Builder(forView: self.view).text("\(error?.code):"+(error?.localizedFailureReason)!).mode(.text).show().hide(afterDelay: 2)
            }else{
                
                if(responseData!["code"] as! Int == ERROR) {
                    
//                    BXProgressHUD.Builder(forView: self.view).text("后台出错").mode(.text).show().hide(afterDelay: 2)
                }
                
                if(responseData!["code"] as! Int == SUCCESS) {
                    
                    
                    let data = responseData!["data"] as! NSDictionary
                    
                    let tempArray = data["recommandPersonList"] as! NSArray
                    
                    
                    
                    
                    for (_, item) in tempArray.enumerated() {
                        
                        let usermodel = UserModel()
                        
                        let itemNode = item as! NSDictionary
                        
                        usermodel.userName = itemNode["name"] as? String
                        usermodel.faceImageName = itemNode["faceImageName"] as? String
                        usermodel.entyName = itemNode["entyDesc"] as? String
                        
                        self.personArray.add(usermodel)
                        
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personArray.count
    }

    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 0){
            
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 4*minSpace))
            view.backgroundColor = UIColor.white
            
            let label = UILabel()
            view.addSubview(label)
            
            label.text = "你可能感兴趣的人"
            label.font = UIFont(name: fontName, size: minFont)
            label.textColor = UIColor.gray
            
            label.snp.makeConstraints({ (make) -> Void in
                
                make.left.equalTo(view.snp.left).offset(2*minSpace)
                make.centerY.equalTo(view.snp.centerY)
            })
            
            return view
        }else{
            return UIView()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section == 0){
            return "你可能感兴趣的人"
        }else{
            return ""
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindTableViewCell", for: indexPath) as! FindTableViewCell

        // Configure the cell...
        
        cell.configureCell(personArray.object(at: (indexPath as NSIndexPath).row) as! UserModel)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
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
