//
//  ResourceOwnerTokenRequest.swift
//  Pods
//
//  Created by Karthik on 24/12/15.
//
//

import UIKit

open class ResourceOwnerTokenRequest: OAuthTokenRequest {
    
   open let userName : String
    
   open let password : String
    
   public init(authDomain: String, clientId: String, clientSecret: String, scope: [String], userName : String, password :String, accessType: OauthAccessType? = nil) {
        
        self.userName = userName
        
        self.password = password
    
        super.init(authDomain: authDomain, grantType: .password, clientId: clientId, clientSecret: clientSecret, scope: scope)
        
        self.accessType = accessType
    }
    
    override open func getRequestParam() -> [String : Any] {
        
        var param = super.getRequestParam()
        
        param[OauthParamName.username] = self.userName
        param[OauthParamName.password] = self.password
        
        return param
    }
}

// MARK: > AuthCode Token Request 
// To get the access token for Authcode
open class AuthCodeTokenRequest: OAuthTokenRequest {
    
    open let code: String
    
    open let redirectUrl: String
    
    public init(authDomain: String, clientId: String, clientSecret: String, code: String, redirectUrl: String) {
        
        self.code = code
        
        self.redirectUrl = redirectUrl
        
        super.init(authDomain: authDomain, grantType: .code, clientId: clientId, clientSecret: clientSecret)
    }
    
    open override func getRequestParam() -> [String : Any] {
        
        var param = super.getRequestParam()
        
        param[OauthParamName.code] = self.code
        param[OauthParamName.redirectUrl] = self.redirectUrl
        
        return param
    }
}

