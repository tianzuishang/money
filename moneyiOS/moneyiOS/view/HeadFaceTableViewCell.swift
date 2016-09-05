//
//  HeadFaceTableViewCell.swift
//  moneyiOS
//
//  Created by wang jam on 9/4/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit


//头像 xxxxxxx 相机

class HeadFaceTableViewCell: UITableViewCell {

    
    let faceView = UIImageView()
    let headLabel = UILabel()
    let headIcon = UIImageView()
    var mymodel = UserModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        headLabel.text = "分享我的照片或动态"
        headLabel.textColor = UIColor.grayColor()
        headLabel.font = UIFont(name: fontName, size: minFont)
        headLabel.sizeToFit()
        
        
        faceView.clipsToBounds = true
        faceView.contentMode = UIViewContentMode.ScaleAspectFill
        faceView.layer.cornerRadius = 6*minSpace/2
        
        
        
        headIcon.image = UIImage(named: "camera_.png")
        headIcon.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        
        
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(faceView)
        self.addSubview(headLabel)
        self.addSubview(headIcon)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(model: UserModel){
        mymodel = model
        
        if(mymodel.faceImageName == "" || mymodel.faceImageName == nil){
            
            faceView.image = UIImage(named: "man-noname.png")
            
        }else{
            
            faceView.kf_setImageWithURL(NSURL(string: ConfigAccess.serverDomain()+mymodel.faceImageName!)!, placeholderImage: nil, optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                
                if(image?.size.height>image?.size.width){
                    
                    let height = 2*6*minSpace
                    let width = 2*6*minSpace*(image?.size.width)!/(image?.size.height)!
                    
                    self.faceView.image = Tool.scaleToSize(image!, newsize: CGSize(width: width, height: height))

                }else{
                    let width = 2*6*minSpace
                    let height = 2*6*minSpace*(image?.size.height)!/(image?.size.width)!
                    self.faceView.image = Tool.scaleToSize(image!, newsize: CGSize(width: width, height: height))
                }
                
            })
            
        }
        
    }
    
    static func cellHeight()->CGFloat {
        return 8*minSpace
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
                faceView.snp_makeConstraints { (make) -> Void in
                    make.left.equalTo(self.snp_left).offset(2*minSpace)
                    make.centerY.equalTo(self.snp_centerY)
                    make.size.width.equalTo(6*minSpace)
                    
                    
                }
        
                headLabel.snp_makeConstraints { (make) -> Void in
                    make.left.equalTo(faceView.snp_right).offset(minSpace)
                    make.centerY.equalTo(faceView.snp_centerY)
                }
        
                headIcon.snp_makeConstraints { (make) -> Void in
                    make.right.equalTo(self.snp_right).offset(-2*minSpace)
                    make.centerY.equalTo(faceView.snp_centerY)
                    make.size.width.equalTo(4*minSpace)
                }

    }


}
