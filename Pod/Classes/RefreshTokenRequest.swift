//
//  RefreshTokenRequest.swift
//  Pods
//
//  Created by Karthik on 24/12/15.
//
//

import UIKit


open class RefreshTokenRequest : OAuthTokenRequest{
    
   open let refreshToken :String
    
   open var expiryType : OauthExpiryType?
    
   public init(authDomain: String, clientId: String, clientSecret: String,refreshToken :String,expiryType : OauthExpiryType? = nil) {
        
        self.refreshToken = refreshToken
        self.expiryType = expiryType
        
        super.init(authDomain: authDomain, grantType : OauthGrantType.REFRESH_TOKEN, clientId: clientId, clientSecret: clientSecret)
    }
    
    override open func getRequestParam() -> [String : AnyObject] {
        
        var param = super.getRequestParam()
        
        param[OauthParamName.REFRESH_TOKEN] = self.refreshToken as AnyObject?
        
        if let expiryType = self.expiryType{
            
            param[OauthParamName.EXPIRY_TYPE] = expiryType.rawValue as AnyObject?
        }
        
        return param
    }
    
}
