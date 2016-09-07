//
//  NewsFeedTableViewCell.swift
//  moneyiOS
//
//  Created by wang jam on 9/7/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit

//头像 名字
//描述*****
//图片
//赞 评论 转发

class NewsFeedTableViewCell: UITableViewCell {

    
    let faceView = UIImageView()
    let nameLabel = UILabel()
    let subLabel = UILabel()
    let contentLabel = UILabel()
    let contentImage = UIImageView()
    let commentCountLabel = UILabel()
    let likeCountLabel = UILabel()
    let publishTimeLabel = UILabel()
    
    
    let commentIcon = UIImageView()
    let shareIcon = UIImageView()
    let likeIcon = UIImageView()
    
    
    let faceViewWidth = 5*minSpace
    
    
    
    var mymodel: NewsFeedModel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        faceView.clipsToBounds = true
        faceView.layer.cornerRadius = faceViewWidth/2
        faceView.contentMode = UIViewContentMode.ScaleAspectFill
        
        contentImage.clipsToBounds = true
        contentImage.contentMode = UIViewContentMode.ScaleAspectFill
        
        commentIcon.image = UIImage(named: "comment_48px.png")
        shareIcon.image = UIImage(named: "heart3.png")
        likeIcon.image = UIImage(named: "Like_64.png")
        
        nameLabel.font = UIFont(name: fontName, size: minFont)
        publishTimeLabel.font = UIFont(name: fontName, size: minminFont)
        subLabel.font = UIFont(name: fontName, size: minminFont)
        subLabel.textColor = UIColor.grayColor()
        
        contentLabel.font = UIFont(name: fontName, size: minFont)
        contentLabel.numberOfLines = 20
        commentCountLabel.font = UIFont(name: fontName, size: minminFont)
        likeCountLabel.font = UIFont(name: fontName, size: minminFont)
        commentCountLabel.textColor = UIColor.grayColor()
        likeCountLabel.textColor = UIColor.grayColor()
        
        self.addSubview(faceView)
        self.addSubview(nameLabel)
        self.addSubview(subLabel)
        self.addSubview(contentLabel)
        self.addSubview(contentImage)
        self.addSubview(commentCountLabel)
        self.addSubview(likeCountLabel)
        self.addSubview(publishTimeLabel)
        
        self.addSubview(commentIcon)
        self.addSubview(shareIcon)
        self.addSubview(likeIcon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(model: NewsFeedModel){
        mymodel = model
        
        nameLabel.text = mymodel.userModel.name
        publishTimeLabel.text = Tool.showTime(mymodel.publishTimestamp)
        subLabel.text = mymodel.headTitle! + "," + mymodel.entyDesc!
        contentLabel.text = mymodel.content
        commentCountLabel.text = "\(mymodel.commentCount)"
        likeCountLabel.text = "\(mymodel.likeCount)"
        
        
        contentLabel.sizeToFit()
        nameLabel.sizeToFit()
        subLabel.sizeToFit()
        publishTimeLabel.sizeToFit()
        
        
        
        
        
        if(mymodel.userModel.faceImageName == "" || mymodel.userModel.faceImageName == nil){
            
            faceView.image = UIImage(named: "man-noname.png")
            
        }else{
            Tool.setFaceViewImage(faceView, faceViewWidth: faceViewWidth, imageUrl: ConfigAccess.serverDomain()+mymodel.userModel.faceImageName!)
        }
        
        
        if(mymodel.contentImageUrl == nil || mymodel.contentImageUrl == ""){
            
            
            
        }else{
            
            contentImage.kf_setImageWithURL(NSURL(string: ConfigAccess.serverDomain()+mymodel.contentImageUrl!)!, placeholderImage: nil)
            
        }
        
        
    }
    
    
    static func cellHeight(model: NewsFeedModel)->CGFloat {
        
        
        return 40*minSpace
    
    
    }

    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        faceView.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(self.snp_left).offset(2*minSpace)
            make.top.equalTo(self.snp_top).offset(2*minSpace)
            make.size.width.equalTo(faceViewWidth)
        }
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(faceView.snp_top)
            make.left.equalTo(faceView.snp_right).offset(minSpace)
        }
        
        publishTimeLabel.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(nameLabel.snp_right).offset(minSpace)
            make.top.equalTo(faceView.snp_top)
            
        }
        
        subLabel.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(faceView.snp_right).offset(minSpace)
            make.top.equalTo(nameLabel.snp_bottom).offset(minSpace/2)
        }
        
        
        
        if(mymodel.content != nil && mymodel.content != ""){
            
            contentLabel.snp_updateConstraints(closure: { (make) -> Void in
                make.left.equalTo(faceView.snp_right).offset(minSpace)
                make.top.equalTo(faceView.snp_bottom).offset(minSpace/2)
                make.right.equalTo(self.snp_right).offset(-2*minSpace)
                make.height.equalTo(8*minSpace)
            })
            
        }else{
            
            contentLabel.snp_updateConstraints(closure: { (make) -> Void in
                make.left.equalTo(faceView.snp_right).offset(minSpace)
                make.top.equalTo(faceView.snp_bottom).offset(minSpace/2)
                make.right.equalTo(self.snp_right).offset(-2*minSpace)
                make.height.equalTo(0*minSpace)
            })
        }
        
        
        if(mymodel.contentImageUrl != nil && mymodel.contentImageUrl != ""){
            
            contentImage.snp_updateConstraints(closure: { (make) -> Void in
                
                make.left.equalTo(faceView.snp_right).offset(minSpace)
                make.top.equalTo(contentLabel.snp_bottom).offset(minSpace/2)
                make.right.equalTo(self.snp_right).offset(-2*minSpace)
                make.height.equalTo(17*minSpace)
                
            })
            
        }else{
            
            contentImage.snp_updateConstraints(closure: { (make) -> Void in
                
                make.left.equalTo(faceView.snp_right).offset(minSpace)
                make.top.equalTo(contentLabel.snp_bottom).offset(minSpace/2)
                make.right.equalTo(self.snp_right).offset(-2*minSpace)
                make.height.equalTo(0*minSpace)
            })
            
        }
        
        
        likeIcon.snp_updateConstraints { (make) -> Void in
            
            make.size.width.equalTo(20)
            make.top.equalTo(contentImage.snp_bottom).offset(minSpace)
            make.left.equalTo(contentImage.snp_left)
        
        }
        
        likeCountLabel.snp_updateConstraints { (make) -> Void in
            
            make.left.equalTo(likeIcon.snp_right).offset(minSpace)
            
            make.centerY.equalTo(likeIcon.snp_centerY)
        }
        
        commentIcon.snp_updateConstraints { (make) -> Void in
            
            make.size.width.equalTo(20)
            make.top.equalTo(contentImage.snp_bottom).offset(minSpace)
            make.centerX.equalTo(contentImage.snp_centerX)
            
        }
        commentCountLabel.snp_updateConstraints { (make) -> Void in
            
            make.left.equalTo(commentIcon.snp_right).offset(minSpace)
            make.centerY.equalTo(commentIcon.snp_centerY)
        }
        
        
        shareIcon.snp_updateConstraints { (make) -> Void in
            
            make.size.width.equalTo(20)
            make.top.equalTo(contentImage.snp_bottom).offset(minSpace)
            make.right.equalTo(contentImage.snp_right)
        }
        
        
        
//        if(mymodel.contentImageUrl != nil&& mymodel.contentImageUrl != ""){
//            
//        }else{
//            
//        }
        
        
    }
    
    
    
}
