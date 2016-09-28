//
//  friendlistCell.swift
//  wxListSample
//
//  Created by wang jam on 7/25/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class SearchPeopleTableViewCell: UITableViewCell {

    var faceImageView: UIImageView
    var nameLabel: UILabel
    var entyNameLabel: UILabel
    var usermodel: UserModel
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        faceImageView = UIImageView()
        nameLabel = UILabel()
        entyNameLabel = UILabel()
        usermodel = UserModel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.font = UIFont(name: fontName, size: minFont)
        entyNameLabel.font = UIFont(name: fontName, size: minminFont)
        entyNameLabel.numberOfLines = 1
        entyNameLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        entyNameLabel.textColor = UIColor.gray
        
        
        faceImageView.contentMode = UIViewContentMode.scaleAspectFit;
        faceImageView.clipsToBounds = true
        
        self.addSubview(entyNameLabel)
        self.addSubview(faceImageView)
        self.addSubview(nameLabel)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(_ model: UserModel) {
        usermodel = model
        nameLabel.text = usermodel.userName
        entyNameLabel.text = usermodel.entyName
        
        
        
        
        
        if(usermodel.faceImageName == nil || usermodel.faceImageName == ""){
            faceImageView.image = UIImage(named: "man-noname.png")
        }else{
            
            faceImageView.kf.setImage(with: URL(string: ConfigAccess.serverDomain()+usermodel.faceImageName!)!)
        }
        
        nameLabel.sizeToFit()
        
        entyNameLabel.sizeToFit()
        
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        faceImageView.snp.makeConstraints { (make) -> Void in
            make.size.height.equalTo(5*minSpace);
            make.left.equalTo(2*minSpace);
            make.top.equalTo(self).offset(minSpace);
        }
        
        
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(faceImageView.snp.right).offset(minSpace)
            make.top.equalTo(self).offset(minSpace)
        }
        
        entyNameLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(faceImageView.snp.right).offset(minSpace)
            make.top.equalTo(nameLabel.snp.bottom).offset(minSpace)
        }
    }
    
    static func cellHeight() -> CGFloat {
        return 54
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
