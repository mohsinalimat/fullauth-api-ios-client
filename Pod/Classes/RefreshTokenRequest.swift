//
//  RefreshTokenRequest.swift
//  Pods
//
//  Created by Karthik on 24/12/15.
//
//

import UIKit


public class RefreshTokenRequest : OAuthTokenRequest{
    
   public let refreshToken :String
    
   public var expiryType : OauthExpiryType?
    
   public init(authDomain: String, clientId: String, clientSecret: String,refreshToken :String,expiryType : OauthExpiryType? = nil) {
        
        self.refreshToken = refreshToken
        self.expiryType = expiryType
        
        super.init(authDomain: authDomain, grantType : OauthGrantType.REFRESH_TOKEN, clientId: clientId, clientSecret: clientSecret)
    }
    
    override public func getRequestParam() -> [String : AnyObject] {
        
        var param = super.getRequestParam()
        
        param[OauthParamName.REFRESH_TOKEN] = self.refreshToken
        
        if let expiryType = self.expiryType{
            
            param[OauthParamName.EXPIRY_TYPE] = expiryType.rawValue
        }
        
        return param
    }
    
}