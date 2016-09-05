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
    
}
