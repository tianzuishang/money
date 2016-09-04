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
    //var subTitle: UILabel
    var source: UILabel
    var publishTime: UILabel
    var titleImageView: UIImageView
    var newsModel: NewsModel
    
    static let titleHeight: CGFloat = 6*minSpace
    static let titleWidth: CGFloat = 28*minSpace
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        title = UILabel()
        //subTitle = UILabel()
        source = UILabel()
        publishTime = UILabel()
        titleImageView = UIImageView()
        newsModel = NewsModel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title.font = UIFont(name: fontName, size: minFont)
        title.textColor = UIColor.blackColor()
        title.numberOfLines = 2
        title.lineBreakMode = NSLineBreakMode.ByTruncatingTail
//        title.frame = CGRectMake(0, 0, NewsTableViewCell.titleWidth, NewsTableViewCell.titleHeight)
        
//        subTitle.font = UIFont(name: fontName, size: minFont)
//        subTitle.textColor = UIColor.darkGrayColor()
        
        source.font = UIFont(name: fontName, size: minminFont)
        source.textColor = UIColor.grayColor()
        
        publishTime.font = UIFont(name: fontName, size: minminFont)
        publishTime.textColor = UIColor.grayColor()
        
        titleImageView.contentMode = UIViewContentMode.ScaleAspectFill
        titleImageView.clipsToBounds = true
        
        self.addSubview(title)
        //self.addSubview(subTitle)
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
        //subTitle.text = newsModel.subTitle
        source.text = newsModel.source
        publishTime.text = newsModel.publishTime
        
        
        
        if(newsModel.titleImageUrl != nil){
            titleImageView.kf_setImageWithURL(NSURL(string: ConfigAccess.serverDomain()+newsModel.titleImageUrl!)!)
        }
        
        //subTitle.sizeToFit()
        source.sizeToFit()
        publishTime.sizeToFit()
        
        
        print("configureCell: %f", title.frame.width)
        //print(subTitle.frame.width)
        print(source.frame.width)
        print(publishTime.frame.width)
        
        
        
    }
    
    static func cellHeight(model: NewsModel)->CGFloat {
        
        //let title = UILabel()
        //let subTitle = UILabel()
        let source = UILabel()
//        title.font = UIFont(name: fontName, size: normalFont)
//        title.numberOfLines = 0
//        title.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        //subTitle.font = UIFont(name: fontName, size: minFont)
        source.font = UIFont(name: fontName, size: minminFont)
        
        //subTitle.text = model.subTitle
        source.text = model.source
        
        //title.sizeToFit();
        //subTitle.sizeToFit()
        source.sizeToFit()
        
        
        return NewsTableViewCell.titleHeight + minSpace + source.frame.height
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(titleImageView.snp_right).offset(2*minSpace)
            make.top.equalTo(self.snp_top)
            make.width.equalTo(NewsTableViewCell.titleWidth)
            make.height.equalTo(NewsTableViewCell.titleHeight)
        }
        
        source.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(title.snp_left)
            make.top.equalTo(title.snp_bottom)
        }
        
        
        publishTime.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(source.snp_right).offset(2*minSpace)
            make.top.equalTo(source.snp_top)
        }
        
        
        titleImageView.snp_updateConstraints(closure: { (make) -> Void in
            make.size.height.equalTo(NewsTableViewCell.cellHeight(self.newsModel) - 2*minSpace)
            make.left.equalTo(2*minSpace)
            make.top.equalTo(minSpace)
        })
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
