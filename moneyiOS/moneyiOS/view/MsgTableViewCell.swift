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
    var mymodel: UserModel = UserModel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        faceView = UIImageView();
        name = UILabel();
        msg = UILabel();
        dateTime = UILabel();
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        faceView.image = UIImage(named: "face.jpg");
        faceView.contentMode = UIViewContentMode.ScaleAspectFit;
        faceView.clipsToBounds = true
        
        name.font = UIFont(name: "Arial", size: normalFont)
        msg.font = UIFont(name: "Arial", size: minFont)
        dateTime.font = UIFont(name: "Arial", size: minFont)
        msg.textColor = UIColor.grayColor()
        dateTime.textColor = UIColor.grayColor()
        
        
        self.addSubview(faceView)
        self.addSubview(name)
        self.addSubview(msg)
        self.addSubview(dateTime)
        
        
        
        print("init cell");
    }
    
    
    func configureCell(model: UserModel) {
        mymodel = model
        name.text = mymodel.userName
        //msg.text = mymodel.lastTalk
        //dateTime.text = mymodel.lastUpdateTimeStr
        
        if(mymodel.faceImageName == nil || mymodel.faceImageName == ""){
            faceView.image = UIImage(named: "man-noname.png")
        }else{
            faceView.kf_setImageWithURL(NSURL(string: ConfigAccess.serverDomain()+mymodel.faceImageName!)!)
        }
        
        
        //判断是否通讯录cell
//        if(mymodel.contactflag == true){
//            faceView.image = UIImage(named: "adress_book_contacts.png")
//        }
        
        
        name.sizeToFit()
        dateTime.sizeToFit()
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        faceView.snp_makeConstraints{ (make) -> Void in
            make.size.height.equalTo(6*minSpace)
            make.left.equalTo(self).offset(2*minSpace)
            make.top.equalTo(self).offset(minSpace)
        }
        
        name.snp_makeConstraints{ (make) -> Void in
            make.left.equalTo(faceView.snp_right).offset(2*minSpace)
            make.top.equalTo(faceView.snp_top).offset(minSpace)
        }
        
        msg.snp_makeConstraints{ (make) -> Void in
            make.width.equalTo(180);
            make.height.equalTo(2*minSpace);
            make.left.equalTo(faceView.snp_right).offset(2*minSpace)
            make.bottom.equalTo(faceView.snp_bottom)
        }
        
        dateTime.snp_makeConstraints{ (make) -> Void in
            make.width.equalTo(8*minSpace);
            make.height.equalTo(2*minSpace);
            make.right.equalTo(self.snp_right)
            make.top.equalTo(faceView.snp_top)
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
