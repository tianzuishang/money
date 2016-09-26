//
//  Tool.swift
//  moneyiOS
//
//  Created by wang jam on 9/5/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
//import BXProgressHUD


class Tool: NSObject {
    
    static func scaleToSize(_ image: UIImage, newsize: CGSize) -> UIImage {
        
        if(UIScreen.main.scale == 2.0){
            UIGraphicsBeginImageContextWithOptions(newsize, false, 2.0)
        }else{
            UIGraphicsBeginImageContext(newsize)
        }
        
        image.draw(in: CGRect(x: 0, y: 0, width: newsize.width, height: newsize.height))
        
        var scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        if(scaledImage == nil){
            scaledImage = image
        }
        UIGraphicsEndImageContext();
        
        return scaledImage!
        
    }
    
    static func setViewImage(imageView: UIImageView, imageUrl: String) {
        imageView.kf.setImage(with: URL(string: imageUrl)!)
    }
    
    static func setFaceViewImage(_ faceView: UIImageView, faceViewWidth: CGFloat, imageUrl: String){
        
        
        faceView.kf.setImage(with: URL(string: imageUrl)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
            
            if(image == nil){
                return
            }
            
            
            
            if(Float((image?.size.height)!) > Float((image?.size.width)!)){
                
                let height = 2*faceViewWidth
                let width = 2*faceViewWidth*(image?.size.width)!/(image?.size.height)!
                
                faceView.image = Tool.scaleToSize(image!, newsize: CGSize(width: width, height: height))
                
            }else{
                let width = 2*faceViewWidth
                let height = 2*faceViewWidth*(image?.size.height)!/(image?.size.width)!
                faceView.image = Tool.scaleToSize(image!, newsize: CGSize(width: width, height: height))
            }
        }
        
        
//        faceView.kf.setImageWithURL(URL(string: imageUrl)!, placeholderImage: nil, optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
//            
//            if(image == nil){
//                return
//            }
//            
//            if(image?.size.height>image?.size.width){
//                
//                let height = 2*faceViewWidth
//                let width = 2*faceViewWidth*(image?.size.width)!/(image?.size.height)!
//                
//                faceView.image = Tool.scaleToSize(image!, newsize: CGSize(width: width, height: height))
//                
//            }else{
//                let width = 2*faceViewWidth
//                let height = 2*faceViewWidth*(image?.size.height)!/(image?.size.width)!
//                faceView.image = Tool.scaleToSize(image!, newsize: CGSize(width: width, height: height))
//            }
//        })
    }
    
    
    
    static func appRootViewController() -> UIViewController {
        
        var appRootVC = UIApplication.shared.keyWindow?.rootViewController
        
        while ((appRootVC!.presentedViewController) != nil) {
            appRootVC = appRootVC!.presentedViewController;
        }
        
        return appRootVC!;
    }
    
    
    static func showMsgBox(_ msg: String){
        let viewCtrl = Tool.appRootViewController()
//        BXProgressHUD.Builder(forView: viewCtrl.view).text(msg).mode(.text).show().hide(afterDelay: 2)
    }
    
    static func showErrorMsgBox(_ errorCode: Int?) {
        
        if(errorCode == nil){
            Tool.showMsgBox("后台返回未知代码")
            
            return;
        }
        
        
        let errorMsg = errorMap[errorCode!]
        if(errorMsg != nil){
            
            if(errorMsg != ""){
                Tool.showMsgBox(errorMsg!)
            }
            
        }else{
            //返回未知代码
            Tool.showMsgBox("后台返回未知代码")
        }
    }
    
    static func getImageWithColor(_ color: UIColor, height: CGFloat) -> UIImage{
        
        let frame = CGRect(x: 0.0, y: 0.0, width: 1.0, height: height)
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext();
        
        context?.setFillColor(color.cgColor);
        context?.fill(frame);
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img!;
    }
    
    
    static func showTime(_ timeStamp:Int) -> String {
        
        
        
        let date = Date()
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
