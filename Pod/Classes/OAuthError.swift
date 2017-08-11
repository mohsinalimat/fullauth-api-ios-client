//
//  Token.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit
import Foundation

public enum OAuthError: Error, CustomStringConvertible {
    
    case error(Error)
    
    case errorCode(OAuthErrorCode)
    
    case illegalParameter(String)
    
    case responseError(error: Error?,errorResponce : OAuthTokenErrorResponse?)
    
    public var description : String{
        
        switch self{
            
        case .illegalParameter(let error):
            return error
            
        case .error(let error):
            return error.localizedDescription
            
        case .errorCode(let errorCode):
            return errorCode.description
            
        case .responseError(let error , let errorResp):
            
            if let err = error {
                return err.localizedDescription
                
            }else if let errResp = errorResp {
                return errResp.description
            }
            
            return ""
        }
    }
}


public enum OAuthErrorCode : String{
    
    case invalidCredentials = "invalid_credentials"
    
    case invalidRequest = "invalid_request"
    
    case invalidClient = "invalid_client"
    
    case invalidClientSecret = "invalid_client_secret"
    
    case invalidCode = "invalid_code"
    
    case invalidScope = "invalid_scope"
    
    case internalServerError = "internal_server_error"
    
    case invalidGrant = "invalid_grant"
    
    case invalidToken = "invalid_token"
    
    case requestFailed = "request_failed"
    
    case invalidDomain = "invalid_domain"
    
    case unAuthorizedClient = "unauthorized_client"
    
    case invalidSubject = "invalid_subject"
    
    case invalidAccessType = "invalid_access_type"
    
    var description: String {
        return self.rawValue
    }
}
