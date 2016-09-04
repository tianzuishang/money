//
//  LiveView.swift
//  moneyiOS
//
//  Created by wang jam on 9/4/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

//view 格式

//头像 直播标题
//头像 名字

class LiveView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let faceView = UIImageView()
    let liveTitleLabel = UILabel()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        
        liveTitleLabel.font = UIFont(name: fontName, size: normalFont)
        liveTitleLabel.textColor = UIColor.blackColor()
        liveTitleLabel.numberOfLines = 2
        //liveTitleLabel.frame = CGRectMake(0, 0, 12*minSpace, 4*minSpace)
        //liveTitleLabel.frame = CGRectMake(0, 0, 120, 40)
        
        nameLabel.font = UIFont(name: fontName, size: minFont)
        nameLabel.textColor = UIColor.grayColor()
        
        
        faceView.layer.cornerRadius = faceView.frame.size.height/2
        faceView.contentMode = UIViewContentMode.ScaleAspectFit;
        faceView.clipsToBounds = true
        
        super.init(frame: frame)
        
        self.addSubview(faceView)
        self.addSubview(liveTitleLabel)
        self.addSubview(nameLabel)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.cornerRadius = 6.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView(livemodel: LiveModel){
        
        nameLabel.text = livemodel.userModel.name
        liveTitleLabel.text = livemodel.liveTitle
        
        if(livemodel.userModel.faceImageName == ""||livemodel.userModel.faceImageName == nil){
                faceView.image = UIImage(named: "man-noname.png")
                
        }else{
            faceView.kf_setImageWithURL(NSURL(string: ConfigAccess.serverDomain()+livemodel.userModel.faceImageName!)!)
        }
        
        //liveTitleLabel.sizeToFit()
        nameLabel.sizeToFit()
    }
    
    
    override func layoutSubviews() {
        
        faceView.snp_makeConstraints { (make) -> Void in
            make.size.width.equalTo(6*minSpace)
            make.left.equalTo(self.snp_left).offset(minSpace)
            make.centerY.equalTo(self.snp_centerY)
        }
        
        
        liveTitleLabel.snp_makeConstraints { (make) -> Void in
            
            make.width.equalTo(16*minSpace)
            make.height.equalTo(5*minSpace)
            make.left.equalTo(faceView.snp_right).offset(minSpace)
            make.top.equalTo(self.snp_top).offset(2*minSpace)
            
        }
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(faceView.snp_right).offset(minSpace)
            make.top.equalTo(liveTitleLabel.snp_bottom)
        }
        
    }
    
}
