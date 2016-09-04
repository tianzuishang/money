//
//  HeadLineTableViewCell.swift
//  moneyiOS
//
//  Created by wang jam on 9/4/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

// 形式
// xxxx          ...

class HeadLineTableViewCell: UITableViewCell {

    
    let headlineLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
        headlineLabel.textColor = UIColor.grayColor()
        headlineLabel.font = UIFont(name: fontName, size: minFont)
        
        self.addSubview(headlineLabel)
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
        headlineLabel.text = labelStr
        headlineLabel.sizeToFit()
    }
    
    static func cellHeight()->CGFloat {
    
        return 4*minSpace
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headlineLabel.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(self.snp_left).offset(2*minSpace)
            make.centerY.equalTo(self.snp_centerY)
            
        }
    }
    
}
