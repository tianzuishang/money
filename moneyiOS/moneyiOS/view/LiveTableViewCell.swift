//
//  LiveTableViewCell.swift
//  moneyiOS
//
//  Created by wang jam on 9/4/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit

//横向滑动的cell list

class LiveTableViewCell: UITableViewCell, UIScrollViewDelegate {

    
    let scrollView = UIScrollView()
    var liveArray = NSMutableArray()
    let titleLabel = UILabel()
    
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
        
        scrollView.frame = CGRectMake(0, 4*minSpace, ScreenWidth, 13*minSpace)
        scrollView.delegate = self
        
        titleLabel.textColor = UIColor.grayColor()
        titleLabel.font = UIFont(name: fontName, size: minFont)
        titleLabel.text = "最近Live"
        titleLabel.frame = CGRectMake(minSpace, minSpace, 0, 0)
        titleLabel.sizeToFit()
        
        self.addSubview(titleLabel)
        self.addSubview(scrollView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(array: NSMutableArray){
        liveArray = array
        
        
        for subview in scrollView.subviews {
            subview.removeFromSuperview()
        }
        
        for(var i=0; i<liveArray.count; ++i) {
            
            let liveview = LiveView(frame: CGRectMake(minSpace+CGFloat(Float(i))*(minSpace+26*minSpace), 0, 26*minSpace, 10*minSpace))
            
            liveview.configureView(liveArray.objectAtIndex(i) as! LiveModel)
            
            scrollView.addSubview(liveview)
        }
        
        
        
        let allLiveView = UIView(frame: CGRectMake(minSpace+CGFloat(Float(liveArray.count))*(minSpace+26*minSpace), 0, 12*minSpace, 10*minSpace))
        allLiveView.layer.borderColor = UIColor.lightGrayColor().CGColor
        allLiveView.layer.borderWidth = 0.5
        allLiveView.layer.cornerRadius = 6.0
        
        let allLabel = UILabel()
        allLabel.text = "全部live"
        allLabel.sizeToFit()
        allLabel.font = UIFont(name: fontName, size: normalFont)
        allLabel.textColor = UIColor.lightGrayColor()
        allLiveView.addSubview(allLabel)
        
        allLabel.snp_makeConstraints { (make) -> Void in
            
            make.center.equalTo(allLiveView.snp_center)
        }
        
        
        scrollView.addSubview(allLiveView)
        
        
        scrollView.contentSize = CGSizeMake(minSpace+CGFloat(Float(liveArray.count))*(minSpace+26*minSpace) + 12*minSpace + minSpace , 0)
    }
    
    static func cellHeight()->CGFloat {
        return 16*minSpace
    }
}
