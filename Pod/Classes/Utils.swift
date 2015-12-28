//
//  Utils.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit

public class Utils {
    
    public class func isNilOrEmptyStr(str: String?) -> Bool {
        
        if (str == nil || str!.isEmpty){
            return true
        }
        return false
    }
}

