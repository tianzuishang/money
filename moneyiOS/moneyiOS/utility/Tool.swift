//
//  Tool.swift
//  moneyiOS
//
//  Created by wang jam on 9/5/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit

class Tool: NSObject {
    
    static func scaleToSize(image: UIImage, newsize: CGSize) -> UIImage {
        
        if(UIScreen.mainScreen().scale == 2.0){
            UIGraphicsBeginImageContextWithOptions(newsize, false, 2.0)
        }else{
            UIGraphicsBeginImageContext(newsize)
        }
        
        image.drawInRect(CGRectMake(0, 0, newsize.width, newsize.height))
        
        var scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        if(scaledImage == nil){
            scaledImage = image
        }
        UIGraphicsEndImageContext();
        
        return scaledImage
        
    }
    
    static func setFaceViewImage(faceView: UIImageView, faceViewWidth: CGFloat, imageUrl: String){
        
        faceView.kf_setImageWithURL(NSURL(string: imageUrl)!, placeholderImage: nil, optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
            
            if(image == nil){
                return
            }
            
            if(image?.size.height>image?.size.width){
                
                let height = 2*faceViewWidth
                let width = 2*faceViewWidth*(image?.size.width)!/(image?.size.height)!
                
                faceView.image = Tool.scaleToSize(image!, newsize: CGSize(width: width, height: height))
                
            }else{
                let width = 2*faceViewWidth
                let height = 2*faceViewWidth*(image?.size.height)!/(image?.size.width)!
                faceView.image = Tool.scaleToSize(image!, newsize: CGSize(width: width, height: height))
            }
        })
    }
    
    
    static func showTime(timeStamp:Int) -> String {
        
        
        
        let date = NSDate()
        let nowTimeStamp = date.timeIntervalSince1970
        
        
        
        let intervals = abs(timeStamp - Int(nowTimeStamp));
        var mins = 0;
        var hours = 0;
        var days = 0;
        var showTimeStr = "";
        
        if (intervals<3600) {
            mins = intervals/60;
            showTimeStr = "\(mins)分钟前"
        }
        else if (intervals<3600*24) {
            hours = intervals/3600;
            showTimeStr = "\(hours)小时前"
        }
        else{
    
            days = intervals/(3600*24);
            if (days>7) {
                showTimeStr = "\(days/7)周前"
            }else{
                showTimeStr = "\(days)天前"
            }
        }
    
        return showTimeStr;
    }
}
