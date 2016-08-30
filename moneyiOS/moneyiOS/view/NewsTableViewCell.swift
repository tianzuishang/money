//
//  NewsTableViewCell.swift
//  UICollectionViewTest
//
//  Created by wang jam on 8/1/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    var title: UILabel
    var subTitle: UILabel
    var source: UILabel
    var publishTime: UILabel
    var titleImageView: UIImageView
    var newsModel: NewsModel
    
    static let titleHeight: CGFloat = 40
    static let titleWidth: CGFloat = 270
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        title = UILabel()
        subTitle = UILabel()
        source = UILabel()
        publishTime = UILabel()
        titleImageView = UIImageView()
        newsModel = NewsModel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title.font = UIFont(name: fontName, size: normalFont)
        title.textColor = UIColor.blackColor()
        title.numberOfLines = 0
        title.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        
        subTitle.font = UIFont(name: fontName, size: minFont)
        subTitle.textColor = UIColor.darkGrayColor()
        
        source.font = UIFont(name: fontName, size: minminFont)
        source.textColor = UIColor.grayColor()
        
        publishTime.font = UIFont(name: fontName, size: minminFont)
        publishTime.textColor = UIColor.grayColor()
        
        titleImageView.contentMode = UIViewContentMode.ScaleAspectFill
        titleImageView.clipsToBounds = true
        
        self.addSubview(title)
        self.addSubview(subTitle)
        self.addSubview(source)
        self.addSubview(publishTime)
        self.addSubview(titleImageView)
        
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: NewsModel){
        newsModel = model
        
        title.text = newsModel.title
        subTitle.text = newsModel.subTitle
        source.text = newsModel.source
        publishTime.text = newsModel.publishTime
        
        
        
        if(newsModel.titleImageUrl != nil){
            titleImageView.kf_setImageWithURL(NSURL(string: ConfigAccess.serverDomain()+newsModel.titleImageUrl!)!)
        }
        
        //title.sizeToFit();
        subTitle.sizeToFit()
        source.sizeToFit()
        publishTime.sizeToFit()
        
        
        print("configureCell: %f", title.frame.width)
        print(subTitle.frame.width)
        print(source.frame.width)
        print(publishTime.frame.width)
        
        
        
    }
    
    static func cellHeight(model: NewsModel)->CGFloat {
        
        let title = UILabel()
        let subTitle = UILabel()
        let source = UILabel()
        title.font = UIFont(name: fontName, size: normalFont)
        title.numberOfLines = 0
        title.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        subTitle.font = UIFont(name: fontName, size: minFont)
        source.font = UIFont(name: fontName, size: minminFont)
        
        subTitle.text = model.subTitle
        source.text = model.source
        
        title.sizeToFit();
        subTitle.sizeToFit()
        source.sizeToFit()
        
        print("cellHeight: %f", title.frame.width)
        title.frame = CGRectMake(0, 0, NewsTableViewCell.titleWidth, NewsTableViewCell.titleHeight)
        
        
        return minSpace + title.frame.height + minSpace + subTitle.frame.height + minSpace + source.frame.height + minSpace
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        if(newsModel.titleImageUrl != nil){
            title.snp_updateConstraints { (make) -> Void in
                make.width.equalTo(NewsTableViewCell.titleWidth - 10*minSpace)
                make.height.equalTo(NewsTableViewCell.titleHeight)
                make.left.equalTo(titleImageView.snp_right).offset(2*minSpace)
                make.top.equalTo(minSpace)
            }

        }else{
            
            title.snp_updateConstraints { (make) -> Void in
                make.width.equalTo(NewsTableViewCell.titleWidth)
                make.height.equalTo(NewsTableViewCell.titleHeight)
                make.left.equalTo(titleImageView.snp_right).offset(2*minSpace)
                make.top.equalTo(minSpace)
            }
        }
        
        
        
        subTitle.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(title.snp_left)
            make.top.equalTo(title.snp_bottom).offset(minSpace)
        }
        
        source.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(title.snp_left)
            make.top.equalTo(subTitle.snp_bottom).offset(minSpace)
        }
        
        
        publishTime.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(source.snp_right).offset(2*minSpace)
            make.top.equalTo(source.snp_top)
        }
        
        if(newsModel.titleImageUrl == nil){
            
            titleImageView.snp_updateConstraints(closure: { (make) -> Void in
                make.width.equalTo(0)
                make.height.equalTo(0)
                make.left.equalTo(0)
                make.top.equalTo(0)
            })
            
        }else{
            titleImageView.snp_updateConstraints(closure: { (make) -> Void in
                make.width.equalTo(12*minSpace)
                make.height.equalTo(NewsTableViewCell.cellHeight(self.newsModel) - 2*minSpace)
                make.left.equalTo(2*minSpace)
                make.top.equalTo(minSpace)
            })
        }
        
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
