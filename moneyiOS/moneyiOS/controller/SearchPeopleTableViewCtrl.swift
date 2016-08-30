//
//  SearchPeopleTableViewCtrl.swift
//  moneyiOS
//
//  Created by wang jam on 8/11/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit

class SearchPeopleTableViewCtrl: UITableViewController, UITextFieldDelegate {

    let userSearchTextField: UITextField = UITextField()
    let userlist = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        userSearchTextField.frame = CGRectMake(0, 0, ScreenWidth - 4*minSpace, 6*minSpace);
        userSearchTextField.textAlignment = NSTextAlignment.Left;
        userSearchTextField.font = UIFont(name: fontName, size: normalFont)
        userSearchTextField.placeholder = "查找银行间的朋友";
        userSearchTextField.delegate = self;
        userSearchTextField.returnKeyType = UIReturnKeyType.Search;
        
        self.tableView.registerClass(SearchPeopleTableViewCell.self, forCellReuseIdentifier: "SearchPeopleTableViewCell");
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell");
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.tableView.backgroundColor = UIColor.whiteColor()
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == userSearchTextField){
            
            
            textField.text = textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            
            if (textField.text?.characters.count == 0||textField.text == nil) {
                return true;
            }
            
            self.searchByDesc(textField.text!)
        }
        return true;

    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        userSearchTextField.resignFirstResponder()
    }
    
    func searchByDesc(desc: String) {
        print(desc)
        
        NewsAPI.userSearch({ (error, responseData) -> Void in
            
            self.userlist.removeAllObjects()
            
            if(error != nil){
                print(error)
            }
            
            if(responseData != nil){
                if(responseData!["code"] as! Int == 0 ){
                    
                    let userArray = responseData!["data"] as! NSArray
                    
                    for userItem in userArray {
                        print(userItem["UDT_USER_DESC"])
                        
                        let userModel = UserModel()
                        userModel.name = userItem["UDT_USER_DESC"] as? String
                        userModel.entyName = userItem["EMA_ENTY_DESC"] as? String
                        userModel.cityDesc = userItem["UDT_CITY_SHRT_DESC"] as? String
                        userModel.prvnceDesc = userItem["UDT_PRVNCE_SHRT_DESC"] as? String
                        
                        
                        self.userlist.addObject(userModel)
                    }
                    
                    self.tableView.reloadData()
                    
                }else{
                    print(responseData!["msg"])
                }
            }
            
            
            }, parameters: ["searchDesc": desc])
    }
    
    
    override func viewDidAppear(animated: Bool) {
        userSearchTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        userSearchTextField.resignFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0){
            return 1
        }else{
            return userlist.count
        }
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 1){
            return "搜索结果"
        }else{
            return ""
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
            
            cell.accessoryView = userSearchTextField;
            cell.selectionStyle = UITableViewCellSelectionStyle.None;
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("SearchPeopleTableViewCell", forIndexPath: indexPath) as! SearchPeopleTableViewCell
            
            cell.configureCell(userlist[indexPath.row] as! UserModel)
            
            return cell

            
        }
        

        // Configure the cell...

    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 44
        }else{
            return SearchPeopleTableViewCell.cellHeight()
        }
        
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 1){
            
            let userDetail = UserDetailTableViewController(style:UITableViewStyle.Grouped)
            
            userDetail.setUserModel(userlist[indexPath.row] as? UserModel)
            
            
            //self.presentViewController(userDetail, animated: true, completion: nil)
            
            self.navigationController?.pushViewController(userDetail, animated: true)
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
