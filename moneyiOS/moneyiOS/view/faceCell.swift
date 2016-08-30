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
    var wx: UILabel
    var userModel: UserModel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        faceView = UIImageView();
        name = UILabel();
        wx = UILabel();
        userModel = UserModel();
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        faceView.image = UIImage(named: "face.jpg");
        faceView.contentMode = UIViewContentMode.ScaleAspectFit;
        
        name.font = UIFont(name: "Arial", size: 18)
        wx.font = UIFont(name: "Arial", size: 14)
        
        wx.textColor = UIColor.grayColor();
        
        self.addSubview(faceView)
        self.addSubview(name)
        self.addSubview(wx)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        faceView.snp_makeConstraints{ (make) -> Void in
            make.size.height.equalTo(74)
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(5)
        }
        
        name.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(faceView.snp_right).offset(5);
            make.centerY.equalTo(self.snp_centerY);
            
            make.width.equalTo(120);
            make.height.equalTo(28);
            
        }
        
//        wx.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(faceView.snp_right).offset(5);
//            make.top.equalTo(name.snp_bottom).offset(5);
//            make.width.equalTo(160)
//            make.height.equalTo(20)
//        }
    }
    
    
    func configureCell(model: UserModel){
        userModel = model
        name.text = userModel.name
        if(userModel.faceImageName != nil && userModel.faceImageName != ""){
            faceView.kf_setImageWithURL(NSURL(string: ConfigAccess.serverDomain()+userModel.faceImageName!)!)
        }else{
            faceView.image = UIImage(named: "man-noname.png")
        }
        
    }
    
    static func cellHeight() ->CGFloat {
        return 88
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
