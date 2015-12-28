//
//  Token.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit
import Foundation

public enum OAuthError : ErrorType,CustomStringConvertible {
    
    case NSError(Foundation.NSError)
    
    case IllegalParameter(String)
    
    case ResponseError(error : Foundation.NSError?,errorResponce : OAuthTokenErrorResponse?)
    
    public var description : String{
        
        switch self{
            
        case .IllegalParameter(let error):
            return error
            
        case NSError(let error) :
            return error.description
            
        case .ResponseError(let error , let errorResp):
            
            if error != nil {
                return error!.description
            }else if errorResp != nil {
                return errorResp!.description
            }
            return ""
        }
    }
}
