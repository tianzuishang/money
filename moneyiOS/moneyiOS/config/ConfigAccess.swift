//
//  ConfigAccess.swift
//  moneyiOS
//
//  Created by wang jam on 8/7/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import JASON

class ConfigAccess: NSObject {
    static func readConfig() ->JSON {
        let configStrPath = Bundle.main.path(forResource: "config", ofType: "geojson")
        
        
        
        
        let data = NSData(contentsOfFile: configStrPath!)
        
        let parsejson = JSON(data)
        
        return parsejson
    }
    
    static func serverDomain() ->String {
        
        let parseJson = ConfigAccess.readConfig()
        var serverDomain = String()
        
#if DEV
        print(parseJson["dev"]["ServerDomain"].string!)
        serverDomain = parseJson["dev"]["ServerDomain"].string!
#endif
        
#if UAT
        print(parseJson["uat"]["ServerDomain"].string!)
        serverDomain = parseJson["uat"]["ServerDomain"].string!
#endif
        
        return serverDomain
    }
}
