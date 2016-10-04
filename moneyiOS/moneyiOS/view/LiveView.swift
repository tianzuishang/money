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
    let faceViewWidth = 6*minSpace
    
    override init(frame: CGRect) {
        
        liveTitleLabel.font = UIFont(name: fontName, size: normalFont)
        liveTitleLabel.textColor = UIColor.black
        liveTitleLabel.numberOfLines = 2
        liveTitleLabel.frame.size = CGSize(width: 0, height: 3*minSpace)
        
        //liveTitleLabel.frame = CGRectMake(0, 0, 12*minSpace, 4*minSpace)
        //liveTitleLabel.frame = CGRectMake(0, 0, 120, 40)
        
        nameLabel.font = UIFont(name: fontName, size: minFont)
        nameLabel.textColor = UIColor.gray
        
        
        faceView.layer.cornerRadius = faceViewWidth/2
        faceView.contentMode = UIViewContentMode.scaleAspectFill;
        faceView.clipsToBounds = true
        
        super.init(frame: frame)
        
        self.addSubview(faceView)
        self.addSubview(liveTitleLabel)
        self.addSubview(nameLabel)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 6.0
        
        
        faceView.snp.makeConstraints { (make) -> Void in
            make.size.width.equalTo(6*minSpace)
            make.left.equalTo(self.snp.left).offset(minSpace)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        
        liveTitleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(faceView.snp.right).offset(minSpace)
            make.right.equalTo(self.snp.right).offset(-minSpace)
            make.top.equalTo(self.snp.top).offset(2*minSpace)
            
        }
        
        nameLabel.snp.makeConstraints { (make) -> Void in
            
            make.left.equalTo(faceView.snp.right).offset(minSpace)
            make.top.equalTo(liveTitleLabel.snp.bottom)
        }

        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView(_ livemodel: LiveModel){
        
        nameLabel.text = livemodel.userModel.userName
        liveTitleLabel.text = livemodel.liveTitle
        nameLabel.sizeToFit()
        liveTitleLabel.sizeToFit()
        
        if(livemodel.userModel.faceImageName == ""||livemodel.userModel.faceImageName == nil){
                faceView.image = UIImage(named: "man-noname.png")
        }else{
            
            
            Tool.setViewImage(imageView: faceView, imageUrl: ConfigAccess.serverDomain()+livemodel.userModel.faceImageName!)
            
        }

    }
}
