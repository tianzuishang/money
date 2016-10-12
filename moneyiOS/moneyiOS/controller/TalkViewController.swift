//
//  TalkViewController.swift
//  moneyiOS
//
//  Created by wang jam on 09/10/2016.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit

class TalkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate {

    
    let talkTableView = UITableView()
    let bottomToolbar = UIView()
    let bottomToolbarHeight = 49
    
    let backGroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
    let bottomBarBack = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    
    let inputTextField = UITextView()
    let microSendButton = UIButton(type: UIButtonType.custom)
    
    
    let microButton = UIButton()
    let keyboardButton = UIButton()
    
    let emotionButton = UIButton()
    let imageButton = UIButton()
    
//    let inputLeftButton = UIButton()
//    let inputRightOneButton = UIButton()
//    let inputRightTwoButton = UIButton()
    
    
    
    
    let inputButtonHeight = 36.0
    
    //let inputTextFieldHeight = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
        self.initTalkTableView()
        self.initBottomToolbar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(TalkViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TalkViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
        
        
    }
    
    
    func keyboardWillHide(_ notification: Notification) {
        print("keyboardWillHide")
        
        
        let duration = (notification as NSNotification).userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = (notification as NSNotification).userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: curve), animations: { () -> Void in
            if(self.talkTableView.frame.origin.y != 0){
                self.talkTableView.frame.origin.y = 0
                self.bottomToolbar.frame.origin = CGPoint(x: 0, y: self.talkTableView.frame.origin.y + self.talkTableView.frame.size.height)
            }
            
            }, completion: nil)
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
        
        print("keyboardWillShow")
        
        
        let duration = (notification as NSNotification).userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = (notification as NSNotification).userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        
        
        //notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
        
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: curve), animations: { () -> Void in
            if(self.talkTableView.frame.origin.y == 0){
                self.talkTableView.frame.origin.y = -(keyboardSize?.height)!
                self.bottomToolbar.frame.origin = CGPoint(x: 0, y: self.bottomToolbar.frame.origin.y - (keyboardSize?.height)!)
            }
            
            }, completion: nil)
        
        // animations settings
        
    }
    
    
    func initTalkTableView() {
        
        talkTableView.delegate = self
        talkTableView.dataSource = self
        talkTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        talkTableView.backgroundColor = backGroundColor
        
        self.view.addSubview(talkTableView)
        
        talkTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom).offset(-bottomToolbarHeight)
        }

        talkTableView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(TalkViewController.clickTalkTableView)))
        
    }
    
    func clickTalkTableView() {
        
        inputTextField.resignFirstResponder()
        
    }
    
    
    
    
    
    func initBottomToolbar() {
        
        self.view.addSubview(bottomToolbar)

        bottomToolbar.snp.makeConstraints { (make) in
            make.top.equalTo(talkTableView.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        bottomToolbar.backgroundColor = bottomBarBack
        
        microButton.frame = CGRect(x: 0, y: 0, width: CGFloat(inputButtonHeight), height: CGFloat(inputButtonHeight))
        microButton.setBackgroundImage(UIImage(named: "ToolViewInputVoice"), for: UIControlState.normal)
        microButton.showsTouchWhenHighlighted = true
        microButton.addTarget(self, action: #selector(TalkViewController.clickMicroButton), for: UIControlEvents.touchDown)
        
        
        keyboardButton.frame = CGRect(x: 0, y: 0, width: CGFloat(inputButtonHeight), height: CGFloat(inputButtonHeight))
        keyboardButton.setBackgroundImage(UIImage(named: "ToolViewKeyboard"), for: UIControlState.normal)
        keyboardButton.showsTouchWhenHighlighted = true
        keyboardButton.addTarget(self, action: #selector(TalkViewController.clickKeyboardButton), for: UIControlEvents.touchDown)
        
        emotionButton.frame = CGRect(x: 0, y: 0, width: CGFloat(inputButtonHeight), height: CGFloat(inputButtonHeight))
        emotionButton.setBackgroundImage(UIImage(named: "ToolViewEmotion"), for: UIControlState.normal)
        emotionButton.showsTouchWhenHighlighted = true
        //let rightButtonItem1 = UIBarButtonItem.init(customView: inputRightOneButton)
        
        
        
        imageButton.frame = CGRect(x: 0, y: 0, width: CGFloat(inputButtonHeight), height: CGFloat(inputButtonHeight))
        imageButton.setBackgroundImage(UIImage(named: "TypeSelectorBtn_Black"), for: UIControlState.normal)
        imageButton.showsTouchWhenHighlighted = true
        //let rightButtonItem2 = UIBarButtonItem.init(customView: inputRightTwoButton)
        
        
        inputTextField.delegate = self
        inputTextField.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        inputTextField.returnKeyType = UIReturnKeyType.done
        inputTextField.keyboardType = UIKeyboardType.default
        inputTextField.font = UIFont(name: fontName, size: minFont)
        inputTextField.isScrollEnabled = true
        inputTextField.autoresizingMask = UIViewAutoresizing.flexibleHeight
        inputTextField.layer.cornerRadius = 4.0
        inputTextField.layer.borderWidth = 0.5
        inputTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        
        microSendButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        microSendButton.setTitle("按住 说话", for: UIControlState.normal)
        microSendButton.setTitleColor(UIColor.gray, for: UIControlState.normal)
        //microSendButton.tintColor = UIColor.gray
        microSendButton.layer.cornerRadius = 4.0
        microSendButton.layer.borderWidth = 0.5
        microSendButton.layer.borderColor = UIColor.lightGray.cgColor
        
        //microSendButton.buttonType = UIButtonType.custom
        
        
        bottomToolbar.addSubview(emotionButton)
        bottomToolbar.addSubview(imageButton)
        bottomToolbar.addSubview(keyboardButton)
        bottomToolbar.addSubview(microSendButton)
        bottomToolbar.addSubview(inputTextField)
        bottomToolbar.addSubview(microButton)
        
//        bottomToolbar.addSubview(inputLeftButton)
//        bottomToolbar.addSubview(inputTextField)
//        bottomToolbar.addSubview(inputRightOneButton)
//        bottomToolbar.addSubview(inputRightTwoButton)
//        
//        inputLeftButton.snp.makeConstraints { (make) in
//            make.left.equalTo(bottomToolbar.snp.left).offset(minSpace)
//            make.centerY.equalTo(bottomToolbar.snp.centerY)
//        }
//        
        imageButton.snp.makeConstraints { (make) in
            
            make.right.equalTo(bottomToolbar.snp.right).offset(-minSpace)
            make.centerY.equalTo(bottomToolbar.snp.centerY)
            make.width.equalTo(inputButtonHeight)
            make.height.equalTo(inputButtonHeight)
        }
//
        emotionButton.snp.makeConstraints { (make) in
            
            make.right.equalTo(imageButton.snp.left).offset(-minSpace)
            make.centerY.equalTo(bottomToolbar.snp.centerY)
            make.width.equalTo(inputButtonHeight)
            make.height.equalTo(inputButtonHeight)

        }

        microButton.snp.makeConstraints { (make) in
            make.left.equalTo(bottomToolbar.snp.left).offset(minSpace)
            make.centerY.equalTo(bottomToolbar.snp.centerY)
            make.width.equalTo(inputButtonHeight)
            make.height.equalTo(inputButtonHeight)

        }
        
        keyboardButton.snp.makeConstraints { (make) in
            make.left.equalTo(bottomToolbar.snp.left).offset(minSpace)
            make.centerY.equalTo(bottomToolbar.snp.centerY)
            make.width.equalTo(inputButtonHeight)
            make.height.equalTo(inputButtonHeight)

        }
        
        
        
        inputTextField.snp.makeConstraints { (make) in
            make.left.equalTo(microButton.snp.right).offset(minSpace)
            make.top.equalTo(bottomToolbar.snp.top).offset(minSpace)
            make.bottom.equalTo(bottomToolbar.snp.bottom).offset(-minSpace)
            make.right.equalTo(emotionButton.snp.left).offset(-minSpace)
        }
        
        microSendButton.snp.makeConstraints { (make) in
            make.left.equalTo(microButton.snp.right).offset(minSpace)
            make.top.equalTo(bottomToolbar.snp.top).offset(minSpace)
            make.bottom.equalTo(bottomToolbar.snp.bottom).offset(-minSpace)
            make.right.equalTo(emotionButton.snp.left).offset(-minSpace)
        }

        
        self.clickKeyboardButton()
        
    }
    
    func clickKeyboardButton() {
        
        keyboardButton.isHidden = true
        microSendButton.isHidden = true
        
        microButton.isHidden = false
        inputTextField.isHidden = false
        
        
        
    }
    
    
    func clickMicroButton() {
        
        //microButton.removeFromSuperview()
        //inputTextField.removeFromSuperview()
        
        keyboardButton.isHidden = false
        microSendButton.isHidden = false
        
        microButton.isHidden = true
        inputTextField.isHidden = true
        
        inputTextField.resignFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
