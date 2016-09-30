//
//  FindTableViewCell.swift
//  moneyiOS
//
//  Created by wang jam on 9/9/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit

//头像 名字
//头像 机构和headtitle        关注按钮

class FindTableViewCell: UITableViewCell {

    
    let nameLabel = UILabel()
    let faceView = UIImageView()
    let subTitle = UILabel()
    let followIcon = UIImageView()
    let followLabel = UILabel()
    
    static let faceViewWidth = 9*minSpace
    
    var mymodel: UserModel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(nameLabel)
        self.addSubview(faceView)
        self.addSubview(subTitle)
        self.addSubview(followIcon)
        self.addSubview(followLabel)
        
        nameLabel.font = UIFont(name: fontName, size: normalFont)
        subTitle.font = UIFont(name:fontName, size: minFont)
        subTitle.textColor = UIColor.gray
        faceView.clipsToBounds = true
        faceView.layer.cornerRadius = FindTableViewCell.faceViewWidth/2
        faceView.contentMode = UIViewContentMode.scaleAspectFill
        
        subTitle.numberOfLines = 2
        subTitle.frame.size = CGSize(width: 0, height: 3*minSpace)
        
        
        followIcon.image = UIImage(named: "Person_add_72px.png")
        followIcon.contentMode = UIViewContentMode.scaleAspectFill
        
        followLabel.font = UIFont(name: fontName, size: minFont)
        followLabel.textColor = themeColor
        
        followLabel.text = "加关注"
        
        self.layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutViews() {
        
        faceView.snp_makeConstraints { (make) -> Void in
            make.size.width.equalTo(FindTableViewCell.faceViewWidth)
            make.left.equalTo(self.snp_left).offset(2*minSpace)
            make.centerY.equalTo(self.snp_centerY)
        }
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(faceView.snp_right).offset(2*minSpace)
            make.top.equalTo(faceView.snp_top).offset(2*minSpace)
            
        }
        
        subTitle.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(nameLabel.snp_left)
            make.top.equalTo(nameLabel.snp_bottom).offset(minSpace)
            make.right.equalTo(followIcon.snp_left).offset(minSpace)
            
        }
        
        
        followIcon.snp_makeConstraints { (make) -> Void in
            
            make.right.equalTo(self.snp_right).offset(-4*minSpace)
            make.top.equalTo(faceView.snp_top).offset(minSpace)
            make.size.width.equalTo(4*minSpace)
        }
        
        followLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(followIcon.snp_bottom).offset(minSpace)
            make.centerX.equalTo(followIcon.snp_centerX)
            
        }
    }
    
    
    static func cellHeight() -> CGFloat{
        return FindTableViewCell.faceViewWidth + 2*minSpace
    }
    
    func configureCell(_ model: UserModel){
        
        mymodel = model
        
        nameLabel.text = mymodel?.userName
        subTitle.text = mymodel?.entyName
        
        if(mymodel?.faceImageName == "" || mymodel?.faceImageName == nil){
            
            faceView.image = UIImage(named: "man-noname.png")
            
        }else{
            Tool.setFaceViewImage(faceView, faceViewWidth: FindTableViewCell.faceViewWidth, imageUrl: ConfigAccess.serverDomain()+(mymodel?.faceImageName)!)
        }
        
        
        nameLabel.sizeToFit()
        subTitle.sizeToFit()
        
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
