//
//  MarketTableViewCell.swift
//  moneyiOS
//
//  Created by wang jam on 8/7/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}



class MarketTableViewCell: UITableViewCell {

    
    var prdcImage: UIImageView
    var myMarketModel: MarketModel
    var titlePrdcLabel: UILabel
    var priceLabel: UILabel
    var bpLabel: UILabel
    var compareTitleLabel: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        myMarketModel = MarketModel()
        titlePrdcLabel = UILabel()
        priceLabel = UILabel()
        bpLabel = UILabel()
        prdcImage = UIImageView()
        compareTitleLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        titlePrdcLabel.font = UIFont(name: fontName, size: normalFont)
        priceLabel.font = UIFont(name: fontName, size: normalFont)
        bpLabel.font = UIFont(name: "Arial-Bold", size: normalFont)
        
        titlePrdcLabel.textColor = UIColor.black
        priceLabel.textColor = UIColor.black
        bpLabel.textColor = UIColor.black
        compareTitleLabel.textColor = UIColor.black
        prdcImage.contentMode = UIViewContentMode.scaleAspectFill
        prdcImage.clipsToBounds = true
        

        
        self.addSubview(titlePrdcLabel)
        self.addSubview(priceLabel)
        self.addSubview(bpLabel)
        self.addSubview(prdcImage)
        self.addSubview(compareTitleLabel)
        self.backgroundColor = backgroundColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ marketModel: MarketModel) {
        myMarketModel = marketModel
        
        titlePrdcLabel.text = myMarketModel.prdcTitle
        priceLabel.text = myMarketModel.price?.description
        bpLabel.text = myMarketModel.bp?.description
        compareTitleLabel.text = myMarketModel.compareTitle
        
        if(myMarketModel.bp >= 0){
            bpLabel.textColor = red
        }else{
            bpLabel.textColor = green
        }
        
        titlePrdcLabel.sizeToFit()
        priceLabel.sizeToFit()
        bpLabel.sizeToFit()
        compareTitleLabel.sizeToFit()
        
        if(myMarketModel.prdcImageUrl != nil){
            
            Tool.setViewImage(imageView: prdcImage, imageUrl: ConfigAccess.serverDomain()+myMarketModel.prdcImageUrl!)
        }
        
    }
    
    static func cellHeight(_ marketModel: MarketModel) ->CGFloat {
        return 44
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(myMarketModel.prdcImageUrl != nil){
            
            prdcImage.snp_remakeConstraints({ (make) -> Void in
                make.width.equalTo(14)
                make.height.equalTo(10)
                make.left.equalTo(self.snp_left).offset(2*minSpace)
                make.centerY.equalTo(self.snp_centerY)
            });
            
            titlePrdcLabel.snp_remakeConstraints { (make) -> Void in
                make.left.equalTo(prdcImage.snp_right).offset(minSpace)
                make.centerY.equalTo(self.snp_centerY)
            }
            
        }else{
            
            prdcImage.snp_remakeConstraints({ (make) -> Void in
                make.width.equalTo(0)
                make.height.equalTo(0)
//                make.left.equalTo(0)
//                make.top.equalTo(0)
            });
            
            titlePrdcLabel.snp_remakeConstraints { (make) -> Void in
                make.left.equalTo(self.snp_left).offset(2*minSpace)
                make.centerY.equalTo(self.snp_centerY)
            }
        }
        
        
        priceLabel.snp_updateConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX).offset(3*minSpace)
            make.centerY.equalTo(titlePrdcLabel.snp_centerY)
        }
        
        bpLabel.snp_updateConstraints { (make) -> Void in
            make.right.equalTo(self.snp_right).offset(-2*minSpace)
            make.centerY.equalTo(titlePrdcLabel.snp_centerY)
        }
        
        
        if(myMarketModel.compareTitle != nil){
            compareTitleLabel.snp_updateConstraints({ (make) -> Void in
                make.right.equalTo(self.snp_right).offset(-2*minSpace)
                make.centerY.equalTo(self.snp_centerY)
            })
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
