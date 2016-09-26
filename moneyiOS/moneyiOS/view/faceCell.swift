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
        
        
        faceView.snp_makeConstraints{ (make) -> Void in
            make.size.height.equalTo(faceCell.faceViewWidth)
            make.left.equalTo(self).offset(2*minSpace)
            make.top.equalTo(self).offset(2*minSpace)
        }
        
        name.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(faceView.snp_right).offset(minSpace);
            make.top.equalTo(faceView.snp_top).offset(minSpace)
        }
        
        sign.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(name.snp_left)
            
            make.top.equalTo(name.snp_bottom).offset(minSpace)
        }
        
        line.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(self.snp_left)
            make.top.equalTo(faceView.snp_bottom).offset(2*minSpace)
            make.height.equalTo(0.5)
            make.right.equalTo(self.snp_right)
        }
        
        
        
        
        newsCount.snp_makeConstraints { (make) -> Void in
            
            make.centerX.equalTo(faceView.snp_centerX)
            make.top.equalTo(line.snp_bottom).offset(2*minSpace)
            
        }
        
        
        newsCountLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(newsCount.snp_bottom)
            make.centerX.equalTo(newsCount.snp_centerX)
            
        }
//
        
        followCount.snp_makeConstraints { (make) -> Void in
            
            //make.right.equalTo(fansCount.snp_left).offset(-2*minSpace)
            make.top.equalTo(line.snp_bottom).offset(2*minSpace)
            make.centerX.equalTo(self.snp_centerX)
            
        }
        
        followCountLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(followCount.snp_bottom)
            make.centerX.equalTo(followCount.snp_centerX)
        }
        
//
        fansCount.snp_makeConstraints { (make) -> Void in
            
            make.right.equalTo(self.snp_right).offset(-4*minSpace)
            make.top.equalTo(line.snp_bottom).offset(2*minSpace)
        }
        
        fansCountLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(fansCount.snp_bottom)
            make.centerX.equalTo(fansCount.snp_centerX)
            
        }
//
//        
//        entyLabel.snp_makeConstraints { (make) -> Void in
//            
//            make.left.equalTo(faceView.snp_left)
//            make.top.equalTo(faceView.snp_bottom).offset(2*minSpace)
//        }
//        
//        cityLabel.snp_makeConstraints { (make) -> Void in
//            
//            make.left.equalTo(faceView.snp_left)
//            make.top.equalTo(entyLabel.snp_bottom).offset(minSpace)
//            
//        }
//        
//        sign.snp_makeConstraints { (make) -> Void in
//            
//            make.left.equalTo(faceView.snp_left)
//            make.top.equalTo(cityLabel.snp_bottom).offset(minSpace)
//        }
//        
//        followButton.snp_makeConstraints { (make) -> Void in
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
