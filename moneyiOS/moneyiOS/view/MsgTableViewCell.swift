//
//  myCell.swift
//  wxListSample
//
//  Created by wang jam on 7/20/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class MsgTableViewCell: UITableViewCell {

    var faceView: UIImageView
    var name: UILabel
    var msg: UILabel
    var dateTime: UILabel
    var mymodel: MsgModel = MsgModel()
    static let faceWidth = 6*minSpace
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        faceView = UIImageView();
        name = UILabel();
        msg = UILabel();
        dateTime = UILabel();
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        faceView.image = UIImage(named: "face.jpg");
        faceView.contentMode = UIViewContentMode.ScaleAspectFill;
        faceView.clipsToBounds = true
        faceView.layer.cornerRadius = 6.0
        
        
        name.font = UIFont(name: fontName, size: minFont)
        msg.font = UIFont(name: fontName, size: minFont)
        dateTime.font = UIFont(name: fontName, size: minminFont)
        msg.textColor = UIColor.grayColor()
        dateTime.textColor = UIColor.grayColor()
        
        
        self.addSubview(faceView)
        self.addSubview(name)
        self.addSubview(msg)
        self.addSubview(dateTime)
        
        
        
        print("init cell");
    }
    
    
    func configureCell(model: MsgModel) {
        mymodel = model
        
        name.text = mymodel.userModel.userName
        msg.text = mymodel.lastTalk
        dateTime.text = Tool.showTime(mymodel.lastTimeStamp)
        
        
        
        if(mymodel.userModel.faceImageName == nil || mymodel.userModel.faceImageName == ""){
            faceView.image = UIImage(named: "man-noname.png")
        }else{
            
            Tool.setFaceViewImage(faceView, faceViewWidth: MsgTableViewCell.faceWidth , imageUrl: ConfigAccess.serverDomain()+mymodel.userModel.faceImageName!)
        }
        
    
        name.sizeToFit()
        dateTime.sizeToFit()
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        faceView.snp_makeConstraints{ (make) -> Void in
            make.size.height.equalTo(MsgTableViewCell.faceWidth)
            make.left.equalTo(self).offset(2*minSpace)
            make.top.equalTo(self).offset(minSpace)
        }
        
        name.snp_makeConstraints{ (make) -> Void in
            make.left.equalTo(faceView.snp_right).offset(minSpace)
            make.top.equalTo(faceView.snp_top).offset(minSpace/2)
        }
        
        msg.snp_makeConstraints{ (make) -> Void in
            make.left.equalTo(faceView.snp_right).offset(minSpace)
            make.right.equalTo(self.snp_right).offset(-2*minSpace)
            make.top.equalTo(name.snp_bottom).offset(minSpace)
        }
        
        dateTime.snp_makeConstraints{ (make) -> Void in
            make.right.equalTo(self.snp_right).offset(-2*minSpace)
            make.top.equalTo(name.snp_top)
        }
    }
    
    
    static func cellHeight() ->CGFloat {
        return 8*minSpace
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

}
