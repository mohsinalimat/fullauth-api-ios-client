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


public enum OAuthErrorCode : String{
    
    case INVALID_CREDENTIALS = "invalid_credentials"

    case INVALID_REQUEST = "invalid_request"
    
    case INVALID_CLIENT = "invalid_client"
    
    case INVALID_CODE = "invalid_code"
    
    case INVALID_SCOPE = "invalid_scope"
    
    case INTERNAL_SERVER_ERROR = "internal_server_error"
    
    case INVALID_GRANT = "invalid_grant"
    
    case INVALID_TOKEN = "invalid_token"
    
    case REQUEST_FAILED = "request_failed"
    
    case INVALID_DOMAIN = "invalid_domain"
    
    case UNAUTHORIZED_CLIENT = "unauthorized_client"
    
    case INVALID_SUBJECT = "invalid_subject"
}
