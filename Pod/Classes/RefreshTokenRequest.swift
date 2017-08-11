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
    
   public init(authDomain: String, clientId: String, clientSecret: String, refreshToken :String, expiryType : OauthExpiryType? = nil) {
        
        self.refreshToken = refreshToken
        self.expiryType = expiryType
        
        super.init(authDomain: authDomain, grantType : .refreshToken, clientId: clientId, clientSecret: clientSecret)
    }
    
    override open func getRequestParam() -> [String : Any] {
        
        var param = super.getRequestParam()
        
        param[OauthParamName.refreshToken] = self.refreshToken
        
        if let expiryType = self.expiryType{
            param[OauthParamName.expiryType] = expiryType.rawValue
        }
        
        return param
    }
    
}
