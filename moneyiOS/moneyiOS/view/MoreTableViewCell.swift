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
        
        
        moreLabel.textColor = UIColor.gray
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(_ labelStr: String) {
        moreLabel.text = labelStr
        moreLabel.sizeToFit()
    }
    
    static func cellHeight()->CGFloat {
        
        return 5*minSpace
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        moreLabel.snp.makeConstraints { (make) -> Void in
            
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
        }
    }

}
