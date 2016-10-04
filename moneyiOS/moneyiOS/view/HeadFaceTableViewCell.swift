//
//  HeadFaceTableViewCell.swift
//  moneyiOS
//
//  Created by wang jam on 9/4/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit


//头像 xxxxxxx 相机

class HeadFaceTableViewCell: UITableViewCell {

    
    let faceView = UIImageView()
    let headLabel = UILabel()
    let headIcon = UIImageView()
    var mymodel = UserModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        headLabel.text = "分享我的照片或动态"
        headLabel.textColor = UIColor.gray
        headLabel.font = UIFont(name: fontName, size: minFont)
        headLabel.sizeToFit()
        
        
        faceView.clipsToBounds = true
        faceView.contentMode = UIViewContentMode.scaleAspectFill
        faceView.layer.cornerRadius = 6*minSpace/2
        
        
        
        headIcon.image = UIImage(named: "camera_.png")
        headIcon.contentMode = UIViewContentMode.scaleAspectFit
        
        
        
        
        self.backgroundColor = UIColor.white
        self.addSubview(faceView)
        self.addSubview(headLabel)
        self.addSubview(headIcon)
        
        
        
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("clickView")))
        
        
        
        
        
    }
    
    func clickView() {
        
        let viewCtrl = Tool.appRootViewController()
        
        viewCtrl.present(UIViewController(), animated: true, completion: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(_ model: UserModel){
        mymodel = model
        
        if(mymodel.faceImageName == "" || mymodel.faceImageName == nil){
            
            faceView.image = UIImage(named: "man-noname.png")
            
        }else{
            
            
            Tool.setFaceViewImage(faceView, faceViewWidth: 2*6*minSpace, imageUrl: ConfigAccess.serverDomain()+mymodel.faceImageName!)
        }
        
    }
    
    static func cellHeight()->CGFloat {
        return 8*minSpace
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
                faceView.snp.makeConstraints { (make) -> Void in
                    make.left.equalTo(self.snp.left).offset(2*minSpace)
                    make.centerY.equalTo(self.snp.centerY)
                    make.size.width.equalTo(6*minSpace)
                    
                    
                }
        
                headLabel.snp.makeConstraints { (make) -> Void in
                    make.left.equalTo(faceView.snp.right).offset(minSpace)
                    make.centerY.equalTo(faceView.snp.centerY)
                }
        
                headIcon.snp.makeConstraints { (make) -> Void in
                    make.right.equalTo(self.snp.right).offset(-2*minSpace)
                    make.centerY.equalTo(faceView.snp.centerY)
                    make.size.width.equalTo(4*minSpace)
                }

    }


}
