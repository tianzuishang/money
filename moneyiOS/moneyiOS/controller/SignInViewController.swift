//
//  SignInViewController.swift
//  moneyiOS
//
//  Created by wang jam on 8/24/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit
//import BXProgressHUD

class SignInViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    let nameTextField: UITextField = UITextField()
    let passwordTextField: UITextField = UITextField()
    let loginButton: UIButton = UIButton()
    let tableview : UITableView = UITableView()
    let label: UILabel = UILabel()
    let otherlabel: UILabel = UILabel()
    
    let leftLine = UIView()
    let rightLine = UIView()
    //let bottomLine = UIView()
    
    
    let wechatButton = UIButton()
    let qqButton = UIButton()
    let weiboButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        label.text = "银河间"
        label.textColor = themeColor
        label.font = UIFont(name: fontName, size: bigbigbigFont)
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isScrollEnabled = false
       
        self.view.addSubview(tableview)
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell");
        tableview.separatorInset = UIEdgeInsetsMake(0,3*minSpace, 0, 3*minSpace);
        tableview.separatorColor = grayFont
        
        
        loginButton.setTitle("登录", for: UIControlState())
        loginButton.titleLabel?.font = UIFont(name: fontName, size: minMiddleFont)
        loginButton.addTarget(self, action: #selector(SignInViewController.loginClick), for: UIControlEvents.touchUpInside)
        loginButton.backgroundColor = themeColor
        loginButton.tintColor = UIColor.white
        loginButton.layer.cornerRadius = 5.0
        loginButton.layer.masksToBounds = true
        loginButton.showsTouchWhenHighlighted = true
        //loginButton.enabled = false
        
        self.view.addSubview(loginButton)
        
        
        
        
        
        label.snp_makeConstraints { (make) -> Void in
            
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(8*minSpace)
            
            make.top.equalTo(8*minSpace)
            make.centerX.equalTo(self.view.snp_centerX)
        }
        
        nameTextField.textAlignment = NSTextAlignment.left;
        nameTextField.font = UIFont(name:fontName, size: normalFont)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "本币账户", attributes: [NSForegroundColorAttributeName: grayFont])
        nameTextField.delegate = self
        
        
        
        
        passwordTextField.textAlignment = NSTextAlignment.left;
        passwordTextField.font = UIFont(name:fontName, size: normalFont)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "密码", attributes: [NSForegroundColorAttributeName: grayFont])

        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        
        
        
        
        nameTextField.addTarget(self, action: #selector(SignInViewController.textChangeAction(_:)), for: UIControlEvents.editingChanged)
        
        passwordTextField.addTarget(self, action: #selector(SignInViewController.textChangeAction(_:)), for: UIControlEvents.editingChanged)
        
        
        self.forbiddenLoginButton()
        
        //添加点击事件
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(SignInViewController.clickView))
        
        self.view.addGestureRecognizer(tapGesture)
        
        
        otherlabel.text = "其他方式登录"
        otherlabel.font = UIFont(name: fontName, size: minFont)
        otherlabel.textColor = grayFont
        otherlabel.textAlignment = NSTextAlignment.center
        otherlabel.sizeToFit()
        
        
        
        leftLine.backgroundColor = grayFont
        rightLine.backgroundColor = grayFont
        //bottomLine.backgroundColor = grayFont
        
        self.view.addSubview(otherlabel)
        self.view.addSubview(leftLine)
        self.view.addSubview(rightLine)
        //self.view.addSubview(bottomLine)
        
        
        
        wechatButton.setBackgroundImage(UIImage(named: "wechat.png"), for: UIControlState())
        weiboButton.setBackgroundImage(UIImage(named: "weibo.png"), for: UIControlState())
        qqButton.setBackgroundImage(UIImage(named: "qq.png"), for: UIControlState())
        
        
        self.view.addSubview(wechatButton)
        self.view.addSubview(qqButton)
        self.view.addSubview(weiboButton)
        
        
        //增加下滑手势
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(SignInViewController.clickView))
        recognizer.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(recognizer)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        
        tableview.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(label.snp_bottom).offset(6*minSpace)
            make.left.equalTo(self.view.snp_left)
            make.width.equalTo(self.view.snp_width)
            make.height.equalTo(12*minSpace)
            
        }
        
        loginButton.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(tableview.snp_bottom).offset(4*minSpace)
            make.left.equalTo(self.view.snp_left).offset(3*minSpace)
            make.width.equalTo(ScreenWidth - 2*3*minSpace)
            make.height.equalTo(6*minSpace)
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardDidHide(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        
        
        wechatButton.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp_bottom).offset(-4*minSpace)
            make.left.equalTo(self.view.snp_left).offset(6*minSpace)
            make.size.height.equalTo(36)
        }
        
        
        qqButton.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(wechatButton.snp_bottom)
            make.centerX.equalTo(self.view.snp_centerX)
            make.size.height.equalTo(36)
        }
        
        weiboButton.snp_makeConstraints { (make) -> Void in
            
            make.bottom.equalTo(wechatButton.snp_bottom)
            make.right.equalTo(self.view.snp_right).offset(-6*minSpace)
            make.size.height.equalTo(36)
        }
        
        
        otherlabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(wechatButton.snp_top).offset(-4*minSpace)
            make.centerX.equalTo(self.view.snp_centerX)
        }
        
        leftLine.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(loginButton.snp_left)
            
            make.centerY.equalTo(otherlabel.snp_centerY)
            
            make.height.equalTo(0.5)
            
            make.right.equalTo(otherlabel.snp_left).offset(-minSpace)
        }
        
        rightLine.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(otherlabel.snp_right).offset(minSpace)
            
            make.centerY.equalTo(otherlabel.snp_centerY)
            
            make.height.equalTo(0.5)
            
            make.right.equalTo(loginButton.snp_right)
        }

        
//        bottomLine.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(loginButton.snp_left)
//            
//            make.top.equalTo(weiboButton.snp_bottom).offset(4*minSpace)
//            
//            make.height.equalTo(0.5)
//            
//            make.right.equalTo(loginButton.snp_right)
//        }

        
    }
    
    
    func enableLoginButton() {
        loginButton.isEnabled = true
        loginButton.backgroundColor = themeColor
    }
    
    func forbiddenLoginButton() {
        loginButton.isEnabled = false
        loginButton.backgroundColor = whiteThemeColor
    }
    
    
    func textChangeAction(_ sender: AnyObject) {
        print("textChangeAction")
        
        
        if(passwordTextField.text != "" && nameTextField.text != ""){
            
            //login button enable
            print("login button enable")
            self.enableLoginButton()
            
        }else{
            //login button forbidden
            print("login button forbidden")
            self.forbiddenLoginButton()
        }

    }
    
    
//    func textFieldDidEndEditing(textField: UITextField) {
//        
//        if(passwordTextField.text != "" && nameTextField.text != ""){
//            
//            //login button enable
//            print("login button enable")
//            self.enableLoginButton()
//            
//        }else{
//            //login button forbidden
//            print("login button forbidden")
//            self.forbiddenLoginButton()
//        }
//        
//    }
    
    
    
    func clickView() {
        nameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func loginClick() {
        
        nameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        //let bxp = BXProgressHUD.showHUDAddedTo(self.view)
        
        self.login(nameTextField.text, password: passwordTextField.text)
        
        
        
    }
    
    func login(_ name:String?, password:String?) {
        
        print("login")
        if(name == "" || password == "" || name == nil || password == nil){
            
            return
        }
        
        
        
        let mySettingData = UserDefaults.standard
        mySettingData.removeObject(forKey: "userID")
        mySettingData.removeObject(forKey: "userPassword")
        mySettingData.synchronize()
        
        let parameters:[String: AnyObject] = [
            "userID": name! as AnyObject,
            "userPassword": password! as AnyObject
        ]
        
        
        if(self.view.isHidden == false){
            Tool.showLoading(msg: "正在登陆")
        }
        
        NewsAPI.login({ (error, responseData) -> Void in
            
//            if(hud != nil){
//                hud!.hide()
//            }
//            
            
            Tool.stoploading()
            
            if(error != nil){
                
                self.view.isHidden = false
//                BXProgressHUD.Builder(forView: self.view).text("\(error?.code):"+(error?.domain)!).mode(.text).show().hide(afterDelay: 2)
                
                Tool.showMsgBox("\(error?.code):"+(error?.domain)!)
                
                
            }else{
                
                
                if(responseData!["code"] as! Int != LOGIN_SUCCESS){
                    self.view.isHidden = false
                    Tool.showErrorMsgBox(responseData!["code"] as? Int)
                    
                }else{
                    print("登录成功")
                    
                    
                    
                    let dataArray = responseData!["data"] as! NSArray
                    
                    if(dataArray.count != 1){
                        print("返回条数有误")
                        return
                    }
                    
                    
                    let userInfoDic = dataArray[0] as! NSDictionary
                    
                    let app = UIApplication.shared.delegate as! AppDelegate;
                    app.myUserInfo = UserModel()
                    
                    app.myUserInfo?.userSrno = (userInfoDic["UDT_USER_SRNO"] as? Int)!
                    app.myUserInfo?.userID = userInfoDic["UDT_USER_USER_ID"] as? String
                    app.myUserInfo?.userName = userInfoDic["UDT_USER_DESC"] as? String
                    app.myUserInfo?.entyName = userInfoDic["EMA_ENTY_ENCD_DESC"] as? String
                    app.myUserInfo?.entySrno = (userInfoDic["EMA_ENTY_SRNO"] as? Int)!
                    app.myUserInfo?.cityDesc = userInfoDic["UDT_CITY_SHRT_DESC"] as? String
                    app.myUserInfo?.prvnceDesc = userInfoDic["UDT_PRVNCE_SHRT_DESC"] as? String
                    app.myUserInfo?.faceImageName = userInfoDic["UDT_USER_FACE"] as? String
                    
                    
                    let mySettingData = UserDefaults.standard
                    
                    mySettingData.set(parameters["userID"]!, forKey: "userID")
                    mySettingData.set(parameters["userPassword"]!, forKey: "userPassword")
                    mySettingData.synchronize()
                    
                    
                    
                    
                    //本地库连接
                    //                    NSLog(@"%@", app.myInfo.user_id);
                    //                    app.locDatabase = [[LocDatabase alloc] init];
                    //                    if(![app.locDatabase connectToDatabase:app.myInfo.user_id]){
                    //                        alertMsg(@"本地数据库问题");
                    //                        return;
                    //                    }
                    
                    
                    let tab = app.tabInit()
                    
                    UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
                    self.present(tab, animated: true, completion: nil)
                    
                    //更新device token
                    //                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                    //                    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
                    //                    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
                    //

                }
                
            }
            
        }, parameters: parameters)
        
        
        //BXProgressHUD.hi
        
//        let hud = BXHUD.showProgress("Loading")
//        hud.hide(afterDelay: 3)
        
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 6*minSpace
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        
        if((indexPath as NSIndexPath).row == 0){
            cell.addSubview(nameTextField)
            nameTextField.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(cell.snp_left).offset(3*minSpace)
                make.bottom.equalTo(cell.snp_bottom)
                make.width.equalTo(ScreenWidth - 2*3*minSpace)
                make.height.equalTo(6*minSpace)
            }
            
            

        }
        
        if((indexPath as NSIndexPath).row == 1){
            cell.addSubview(passwordTextField)
            passwordTextField.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(cell.snp_left).offset(3*minSpace)
                make.bottom.equalTo(cell.snp_bottom)

                make.width.equalTo(ScreenWidth - 2*3*minSpace)
                make.height.equalTo(6*minSpace)
            }
        }
        
        // Configure the cell...
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell

        
    }
    
    

    
    func keyboardWillHide(_ notification: Notification) {
        print("keyboardWillHide")
        let duration = (notification as NSNotification).userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = (notification as NSNotification).userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        UIView.animate(withDuration: duration, delay: 0.1, options: UIViewAnimationOptions(rawValue: curve), animations: { () -> Void in
            if(self.view.frame.origin.y != 0){
                self.view.frame.origin.y = 0
            }
            
            }, completion: nil)
        
    }

    func keyboardDidHide(_ notification: Notification) {
        
    }
    
    func keyboardDidShow(_ notification: Notification) {
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
        print("keyboardWillShow")
        
        
        let duration = (notification as NSNotification).userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = (notification as NSNotification).userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        
        
        UIView.animate(withDuration: duration, delay: 0.1, options: UIViewAnimationOptions(rawValue: curve), animations: { () -> Void in
            if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y = -8*minSpace
            }

            }, completion: nil)
        
        // animations settings
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
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
