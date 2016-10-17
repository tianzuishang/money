//
//  TalkMsgTableViewCell.swift
//  moneyiOS
//
//  Created by wang jam on 14/10/2016.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit

class TalkMsgTableViewCell: UITableViewCell {

    let faceImage: UIImageView
    let msgButton: UIButton
    var talkMsgModel: TalkMsgModel?
    
    static let faceImageHeight:CGFloat = 44
    
    static let msgButtonMaxWidth = ScreenWidth - 4*minSpace - 2*TalkMsgTableViewCell.faceImageHeight

    
    //let msgLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        faceImage = UIImageView()
        faceImage.contentMode = UIViewContentMode.scaleAspectFill;
        faceImage.clipsToBounds = true
        
        
        msgButton = TalkMsgTableViewCell.getMsgButton()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.addSubview(faceImage)
        self.addSubview(msgButton)
        
        self.backgroundColor = talkbackGroundColor
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    static func getMsgButton() -> UIButton {
        
        let msgButton = UIButton(type: UIButtonType.custom)
        msgButton.layer.cornerRadius = 4.0
        msgButton.setTitle("", for: UIControlState.normal)
        msgButton.titleLabel?.font = UIFont(name: fontName, size: normalFont)
        msgButton.titleLabel?.numberOfLines = 0
        msgButton.titleLabel?.frame.size = CGSize(width: TalkMsgTableViewCell.msgButtonMaxWidth - 2*minSpace, height: CGFloat(FLT_MAX))
        
        msgButton.contentEdgeInsets = UIEdgeInsets(top: minSpace, left: minSpace, bottom: minSpace, right: minSpace)
        
        return msgButton
        
    }
    
    func configureCell(_ model: TalkMsgModel) {
        
        talkMsgModel = model
        let myUserInfo = (UIApplication.shared.delegate as! AppDelegate).myUserInfo
        
        msgButton.titleLabel?.frame.size = CGSize(width: TalkMsgTableViewCell.msgButtonMaxWidth - 2*minSpace, height: CGFloat(FLT_MAX))
        msgButton.setTitle(talkMsgModel?.msg, for: UIControlState.normal)
        msgButton.titleLabel?.sizeToFit()
        
        Tool.setFaceViewImage(faceImage, faceViewWidth: CGFloat(TalkMsgTableViewCell.faceImageHeight), imageUrl: ConfigAccess.serverDomain() + (talkMsgModel?.userModel.faceImageName)!)
        
        
        
        
        if(myUserInfo?.userSrno != talkMsgModel?.userModel.userSrno){
            //对方聊天信息
            //白色
            //左边
            
            
            faceImage.snp.remakeConstraints({ (make) in
                
                make.left.equalTo(self.snp.left).offset(minSpace)
                make.top.equalTo(self.snp.top).offset(minSpace)
                make.size.height.equalTo(TalkMsgTableViewCell.faceImageHeight)
                
            })
            
            msgButton.backgroundColor = UIColor.white
            msgButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            msgButton.snp.remakeConstraints({ (make) in
                make.left.equalTo(faceImage.snp.right).offset(minSpace)
                make.top.equalTo(faceImage.snp.top)
                make.width.equalTo((msgButton.titleLabel?.frame.size.width)!+2*minSpace)
                make.height.equalTo((msgButton.titleLabel?.frame.size.height)! + 2*minSpace)
            })
            
            
        }else{
            //本方聊天信息
            //主题色
            //右边
            
            faceImage.snp.remakeConstraints({ (make) in
                
                make.right.equalTo(self.snp.right).offset(-minSpace)
                make.top.equalTo(self.snp.top).offset(minSpace)
                make.size.height.equalTo(TalkMsgTableViewCell.faceImageHeight)
                
            })
            
            msgButton.backgroundColor = themeColor
            msgButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            
            msgButton.snp.remakeConstraints({ (make) in
                make.right.equalTo(faceImage.snp.left).offset(-minSpace)
                make.top.equalTo(faceImage.snp.top)
                make.width.equalTo((msgButton.titleLabel?.frame.size.width)! + 2*minSpace)
                make.height.equalTo((msgButton.titleLabel?.frame.size.height)! + 2*minSpace)
            })
        }
        
    }

    
    static func cellHeight (model: TalkMsgModel) ->CGFloat {
        
        
        let msgbutton = TalkMsgTableViewCell.getMsgButton()
        
        msgbutton.setTitle(model.msg, for: UIControlState.normal)
        
        msgbutton.titleLabel?.sizeToFit()
        
        
        print(msgbutton.titleLabel?.frame.size.height)
        
        if(TalkMsgTableViewCell.faceImageHeight > (msgbutton.titleLabel?.frame.size.height)! + 2*minSpace){
            
            return TalkMsgTableViewCell.faceImageHeight + 4*minSpace
            
        }else{
            
            return (msgbutton.titleLabel?.frame.height)! + 6*minSpace
            
        }
        
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
