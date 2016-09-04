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
        
        scrollView.frame = CGRectMake(0, 4*minSpace, ScreenWidth, 8*minSpace)
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
            
            let liveview = LiveView(frame: CGRectMake(minSpace+CGFloat(Float(i))*(minSpace+30*minSpace), 0, 30*minSpace, 9*minSpace))
            
            liveview.configureView(liveArray.objectAtIndex(i) as! LiveModel)
            
            scrollView.addSubview(liveview)
        }
        
        scrollView.contentSize = CGSizeMake(minSpace+CGFloat(Float(liveArray.count))*(minSpace+30*minSpace) , 0)
    }
    
    static func cellHeight()->CGFloat {
        return 15*minSpace
    }
}
