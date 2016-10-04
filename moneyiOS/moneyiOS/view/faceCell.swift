//
//  faceCell.swift
//  wxListSample
//
//  Created by wang jam on 7/22/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher


class faceCell: UITableViewCell {

    var faceView: UIImageView
    var name: UILabel
    var sign: UILabel
    var cityLabel: UILabel
    var followButton: UIButton
    var entyLabel: UILabel
    
    
    var newsCountLabel: UILabel
    var newsCount: UILabel
    
    var followCountLabel: UILabel
    var followCount: UILabel
    
    var fansCountLabel: UILabel
    var fansCount: UILabel
    
    
    var line: UIView
    
    var userModel: UserModel
    
    static let faceViewWidth = 8*minSpace
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        faceView = UIImageView();
        name = UILabel();
        sign = UILabel()
        cityLabel = UILabel()
        followButton = UIButton()
        entyLabel = UILabel()
        newsCount = UILabel()
        followCount = UILabel()
        fansCount = UILabel()
        
        newsCountLabel = UILabel()
        fansCountLabel = UILabel()
        followCountLabel = UILabel()
        
        line = UIView()
        line.backgroundColor = grayBackgroundColor
        
        userModel = UserModel();
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        faceView.contentMode = UIViewContentMode.scaleAspectFill;
        faceView.layer.cornerRadius = faceCell.faceViewWidth/2
        faceView.clipsToBounds = true
        name.font = UIFont(name: fontName, size: normalFont)
        sign.font = UIFont(name: fontName, size: minFont)
        sign.textColor = UIColor.gray
        cityLabel.font = UIFont(name: fontName, size: minFont)
        cityLabel.textColor = UIColor.gray
        entyLabel.font = UIFont(name: fontName, size: minFont)
        entyLabel.textColor = UIColor.gray
        
        newsCount.font = UIFont(name: fontName, size: normalFont)
        followCount.font = UIFont(name: fontName, size: normalFont)
        fansCount.font = UIFont(name: fontName, size: normalFont)
        
        
        newsCount.textAlignment = NSTextAlignment.center
        followCount.textAlignment = NSTextAlignment.center
        fansCount.textAlignment = NSTextAlignment.center
        
        newsCountLabel.text = "帖子"
        followCountLabel.text = "关注"
        fansCountLabel.text = "粉丝"
        
        
        newsCountLabel.textColor = UIColor.gray
        followCountLabel.textColor = UIColor.gray
        fansCountLabel.textColor = UIColor.gray

        
        newsCountLabel.font = UIFont(name: fontName, size: minFont)
        followCountLabel.font = UIFont(name: fontName, size: minFont)
        fansCountLabel.font = UIFont(name: fontName, size: minFont)
        
        self.addSubview(faceView)
        self.addSubview(name)
        self.addSubview(sign)
        self.addSubview(cityLabel)
        self.addSubview(followButton)
        self.addSubview(entyLabel)
        self.addSubview(newsCount)
        self.addSubview(followCount)
        self.addSubview(fansCount)
        self.addSubview(newsCountLabel)
        self.addSubview(followCountLabel)
        self.addSubview(fansCountLabel)
        self.addSubview(line)
        
        self.layoutViews()
        
    }

    
    func layoutViews() {
        
        
        faceView.snp.makeConstraints{ (make) -> Void in
            make.size.height.equalTo(faceCell.faceViewWidth)
            make.left.equalTo(self).offset(2*minSpace)
            make.top.equalTo(self).offset(2*minSpace)
        }
        
        name.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(faceView.snp.right).offset(minSpace);
            make.top.equalTo(faceView.snp.top).offset(minSpace)
        }
        
        sign.snp.makeConstraints { (make) -> Void in
            
            make.left.equalTo(name.snp.left)
            
            make.top.equalTo(name.snp.bottom).offset(minSpace)
        }
        
        line.snp.makeConstraints { (make) -> Void in
            
            make.left.equalTo(self.snp.left)
            make.top.equalTo(faceView.snp.bottom).offset(2*minSpace)
            make.height.equalTo(0.5)
            make.right.equalTo(self.snp.right)
        }
        
        
        
        
        newsCount.snp.makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(faceView.snp.centerX)
            make.top.equalTo(line.snp.bottom).offset(2*minSpace)
            
        }
        
        
        newsCountLabel.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(newsCount.snp.bottom)
            make.centerX.equalTo(newsCount.snp.centerX)
            
        }
//
        
        followCount.snp.makeConstraints { (make) -> Void in
            
            //make.right.equalTo(fansCount.snp.left).offset(-2*minSpace)
            make.top.equalTo(line.snp.bottom).offset(2*minSpace)
            make.centerX.equalTo(self.snp.centerX)
            
        }
        
        followCountLabel.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(followCount.snp.bottom)
            make.centerX.equalTo(followCount.snp.centerX)
        }
        
//
        fansCount.snp.makeConstraints { (make) -> Void in
            
            make.right.equalTo(self.snp.right).offset(-4*minSpace)
            make.top.equalTo(line.snp.bottom).offset(2*minSpace)
        }
        
        fansCountLabel.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(fansCount.snp.bottom)
            make.centerX.equalTo(fansCount.snp.centerX)
            
        }
//
//        
//        entyLabel.snp.makeConstraints { (make) -> Void in
//            
//            make.left.equalTo(faceView.snp.left)
//            make.top.equalTo(faceView.snp.bottom).offset(2*minSpace)
//        }
//        
//        cityLabel.snp.makeConstraints { (make) -> Void in
//            
//            make.left.equalTo(faceView.snp.left)
//            make.top.equalTo(entyLabel.snp.bottom).offset(minSpace)
//            
//        }
//        
//        sign.snp.makeConstraints { (make) -> Void in
//            
//            make.left.equalTo(faceView.snp.left)
//            make.top.equalTo(cityLabel.snp.bottom).offset(minSpace)
//        }
//        
//        followButton.snp.makeConstraints { (make) -> Void in
//            
//            
//            
//        }

    }
    
    
    func configureCell(_ model: UserModel){
        userModel = model
        name.text = userModel.userName
        if(userModel.faceImageName != nil && userModel.faceImageName != ""){
            
            
            Tool.setFaceViewImage(faceView, faceViewWidth: faceCell.faceViewWidth, imageUrl: ConfigAccess.serverDomain()+userModel.faceImageName!)
        }else{
            faceView.image = UIImage(named: "man-noname.png")
        }
        
        //entyLabel.text = userModel.entyName
        //cityLabel.text = userModel.cityDesc
        sign.text = userModel.sign
        sign.text = "签名要写什么"
        newsCount.text = "2126"
        followCount.text = "330"
        fansCount.text = "282"
        
    }
    
    static func cellHeight() ->CGFloat {
        return 21*minSpace
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
