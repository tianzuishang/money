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
    var liveViewArray = NSMutableArray()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        scrollView.frame = CGRect(x: 0, y: 4*minSpace, width: ScreenWidth, height: 13*minSpace)
        scrollView.delegate = self
        
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont(name: fontName, size: minFont)
        titleLabel.text = "最近Live"
        titleLabel.frame = CGRect(x: minSpace, y: minSpace, width: 0, height: 0)
        titleLabel.sizeToFit()
        
        self.addSubview(titleLabel)
        self.addSubview(scrollView)
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(_ array: NSMutableArray){
        
        liveArray = array
        
        if(liveArray.count == liveViewArray.count){
            
            //复用以前的view
            
            for i in 0 ..< liveViewArray.count {
                
                let liveview = liveViewArray.object(at: i) as! LiveView
                
                liveview.configureView(liveArray.object(at: i) as! LiveModel)
            }

            
        }else{
            
            liveViewArray.removeAllObjects()
            
            for subview in scrollView.subviews {
                subview.removeFromSuperview()
            }
            
            
            for i in 0 ..< liveArray.count  {
                
                let liveview = LiveView(frame: CGRect(x: minSpace+CGFloat(Float(i))*(minSpace+26*minSpace), y: 0, width: 26*minSpace, height: 10*minSpace))
                
                liveViewArray.add(liveview)
                
                scrollView.addSubview(liveview)
            }
            
            
            
            
            let allLiveView = UIView(frame: CGRect(x: minSpace+CGFloat(Float(liveViewArray.count))*(minSpace+26*minSpace), y: 0, width: 12*minSpace, height: 10*minSpace))
            allLiveView.layer.borderColor = UIColor.lightGray.cgColor
            allLiveView.layer.borderWidth = 0.5
            allLiveView.layer.cornerRadius = 6.0
            
            let allLabel = UILabel()
            allLabel.text = "全部live"
            allLabel.sizeToFit()
            allLabel.font = UIFont(name: fontName, size: normalFont)
            allLabel.textColor = UIColor.lightGray
            allLiveView.addSubview(allLabel)
            
            allLabel.snp_makeConstraints { (make) -> Void in
                
                make.center.equalTo(allLiveView.snp_center)
            }
            
            
            scrollView.addSubview(allLiveView)
            
            
            let width = minSpace + CGFloat(Float(liveViewArray.count))*(minSpace+26*minSpace) + 12*minSpace + minSpace
            
            
            
            scrollView.contentSize = CGSize(width: width, height: 0)
            
            for i in 0 ..< liveViewArray.count {
                
                let liveview = liveViewArray.object(at: i) as! LiveView
                
                liveview.configureView(liveArray.object(at: i) as! LiveModel)
            }
            
        }
        
        
    }
    
    static func cellHeight()->CGFloat {
        return 16*minSpace
    }
}
