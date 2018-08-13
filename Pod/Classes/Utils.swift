//
//  Utils.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit

open class Utils {
    
    open class func isNilOrEmptyStr(_ str: String?) -> Bool {
        
        if (str == nil || str!.isEmpty) {
            return true
        }
        return false
    }
}

