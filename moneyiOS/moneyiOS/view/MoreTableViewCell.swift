//
//  MoreTableViewCell.swift
//  moneyiOS
//
//  Created by wang jam on 9/4/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit

//cell形式
//..........更多...........

class MoreTableViewCell: UITableViewCell {

    let moreLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        moreLabel.textColor = UIColor.grayColor()
        moreLabel.font = UIFont(name: fontName, size: minFont)
        moreLabel.text = "更多"
        
        self.addSubview(moreLabel)
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

    
    func configureCell(labelStr: String) {
        moreLabel.text = labelStr
        moreLabel.sizeToFit()
    }
    
    static func cellHeight()->CGFloat {
        
        return 4*minSpace
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        moreLabel.snp_makeConstraints { (make) -> Void in
            
            make.centerY.equalTo(self.snp_centerY)
            make.centerX.equalTo(self.snp_centerX)
        }
    }

}
