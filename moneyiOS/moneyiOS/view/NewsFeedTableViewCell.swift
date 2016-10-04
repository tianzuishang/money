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
    
    
    static let faceViewWidth:CGFloat = 5*minSpace
    static let contentImageHeight:CGFloat = 17*minSpace
    static let iconHeight:CGFloat = 20
    
    var mymodel: NewsFeedModel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        faceView.clipsToBounds = true
        faceView.layer.cornerRadius = NewsFeedTableViewCell.faceViewWidth/2
        faceView.contentMode = UIViewContentMode.scaleAspectFill
        
        contentImage.clipsToBounds = true
        contentImage.contentMode = UIViewContentMode.scaleAspectFill
        
        commentIcon.image = UIImage(named: "comment_48px.png")
        shareIcon.image = UIImage(named: "heart3.png")
        likeIcon.image = UIImage(named: "Like_64.png")
        
        nameLabel.font = UIFont(name: fontName, size: normalFont)
        publishTimeLabel.font = UIFont(name: fontName, size: minminFont)
        subLabel.font = UIFont(name: fontName, size: minminFont)
        subLabel.textColor = UIColor.gray
        
        contentLabel.font = UIFont(name: fontName, size: normalFont)
        contentLabel.numberOfLines = 20
        contentLabel.frame.size = CGSize(width: 0, height: 20*minSpace)
        
        
        commentCountLabel.font = UIFont(name: fontName, size: minminFont)
        likeCountLabel.font = UIFont(name: fontName, size: minminFont)
        commentCountLabel.textColor = UIColor.gray
        likeCountLabel.textColor = UIColor.gray
        
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
        
        
        contentImage.isUserInteractionEnabled = true
        contentImage.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(NewsFeedTableViewCell.clickImage(_:))))
        
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        self.layoutView()
        
    }
    
    func clickImage(_ sender: UITapGestureRecognizer) {
        print("clickImage")
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

    
    func configureCell(_ model: NewsFeedModel){
        mymodel = model
        
        nameLabel.text = mymodel.userModel.userName
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
            Tool.setFaceViewImage(faceView, faceViewWidth: NewsFeedTableViewCell.faceViewWidth, imageUrl: ConfigAccess.serverDomain()+mymodel.userModel.faceImageName!)
        }
        
        
        if(mymodel.contentImageUrl == nil || mymodel.contentImageUrl == ""){
            
            
            
        }else{
            
            
            Tool.setViewImage(imageView: contentImage, imageUrl: ConfigAccess.serverDomain()+mymodel.contentImageUrl!)
                        
        }
        
        
        
        
        if(mymodel.content != nil && mymodel.content != ""){
            
            contentLabel.snp.updateConstraints({ (make) -> Void in
                //make.height.equalTo(20*minSpace)
                make.top.equalTo(faceView.snp.bottom).offset(minSpace)
            })
            
        }else{
            
            contentLabel.snp.updateConstraints({ (make) -> Void in
                //make.height.equalTo(0*minSpace)
                make.top.equalTo(faceView.snp.bottom)
            })
        }

        
        if(mymodel.contentImageUrl != nil && mymodel.contentImageUrl != ""){
            
            contentImage.snp.updateConstraints({ (make) -> Void in
                make.height.equalTo(NewsFeedTableViewCell.contentImageHeight)
                make.top.equalTo(contentLabel.snp.bottom).offset(minSpace)
            })
            
        }else{
            
            contentImage.snp.updateConstraints({ (make) -> Void in
                make.height.equalTo(0*minSpace)
                make.top.equalTo(contentLabel.snp.bottom)
            })
        }
        
        
    }
    
    
    static func cellHeight(_ model: NewsFeedModel)->CGFloat {
        
        
        var contentImageHeight:CGFloat = 0.0
        var contentHeight: CGFloat = 0.0
        
        if(model.contentImageUrl == nil || model.contentImageUrl == ""){
            
            contentImageHeight = 0.0
            
        }else{
            contentImageHeight = NewsFeedTableViewCell.contentImageHeight + minSpace
        }
        
        if(model.content == "" || model.content == nil){
            contentHeight = 0.0
        }else{
            
            let contentTempLabel = UILabel()
            contentTempLabel.font = UIFont(name: fontName, size: normalFont)
            contentTempLabel.numberOfLines = 20
            contentTempLabel.frame.size = CGSize(width: ScreenWidth - minSpace - NewsFeedTableViewCell.faceViewWidth - minSpace - 2*minSpace , height: 20*minSpace)
            contentTempLabel.text = model.content
            contentTempLabel.sizeToFit()
            
            contentHeight = contentTempLabel.frame.size.height + minSpace
            
        }
        
        
        
        return 2*minSpace+NewsFeedTableViewCell.faceViewWidth+minSpace+contentHeight+contentImageHeight+NewsFeedTableViewCell.iconHeight+2*minSpace
        
        //return 2*minSpace+NewsFeedTableViewCell.faceViewWidth+minSpace+contentHeight+contentImageHeight+NewsFeedTableViewCell.iconHeight+minSpace
    }

    
    
    func layoutView() {
        faceView.snp.makeConstraints { (make) -> Void in
            
            make.left.equalTo(self.snp.left).offset(2*minSpace)
            make.top.equalTo(self.snp.top).offset(2*minSpace)
            make.size.width.equalTo(NewsFeedTableViewCell.faceViewWidth)
        }
        
        nameLabel.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(faceView.snp.top)
            make.left.equalTo(faceView.snp.right).offset(minSpace)
        }
        
        publishTimeLabel.snp.makeConstraints { (make) -> Void in
            
            make.left.equalTo(nameLabel.snp.right).offset(minSpace)
            make.top.equalTo(faceView.snp.top)
            
        }
        
        subLabel.snp.makeConstraints { (make) -> Void in
            
            make.left.equalTo(faceView.snp.right).offset(minSpace)
            make.top.equalTo(nameLabel.snp.bottom).offset(minSpace/2)
        }
        
        likeIcon.snp.makeConstraints { (make) -> Void in
            
            make.size.width.equalTo(20)
            make.top.equalTo(contentImage.snp.bottom).offset(minSpace)
            make.left.equalTo(contentImage.snp.left)
            
        }
        
        likeCountLabel.snp.makeConstraints { (make) -> Void in
            
            make.left.equalTo(likeIcon.snp.right).offset(minSpace)
            
            make.centerY.equalTo(likeIcon.snp.centerY)
        }
        
        commentIcon.snp.makeConstraints { (make) -> Void in
            
            make.size.width.equalTo(20)
            make.top.equalTo(contentImage.snp.bottom).offset(minSpace)
            make.centerX.equalTo(contentImage.snp.centerX)
            
        }
        
        commentCountLabel.snp.makeConstraints { (make) -> Void in
            
            make.left.equalTo(commentIcon.snp.right).offset(minSpace)
            make.centerY.equalTo(commentIcon.snp.centerY)
        }
        
        
        shareIcon.snp.makeConstraints { (make) -> Void in
            
            make.size.width.equalTo(20)
            make.top.equalTo(contentImage.snp.bottom).offset(minSpace)
            make.right.equalTo(contentImage.snp.right)
        }
        
        
        contentLabel.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(faceView.snp.right).offset(minSpace)
            make.top.equalTo(faceView.snp.bottom)
            make.right.equalTo(self.snp.right).offset(-2*minSpace)
            //make.height.equalTo(20*minSpace)
        })
        
        contentImage.snp.makeConstraints({ (make) -> Void in
            
            make.left.equalTo(faceView.snp.right).offset(minSpace)
            make.top.equalTo(contentLabel.snp.bottom)
            make.right.equalTo(self.snp.right).offset(-2*minSpace)
            make.height.equalTo(0*minSpace)
            
        })

    }
    
}
