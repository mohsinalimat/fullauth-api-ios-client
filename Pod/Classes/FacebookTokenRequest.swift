//
//  FacebookTokenRequest.swift
//  Pods
//
//  Created by Karthik on 24/12/15.
//
//

import UIKit

open class FacebookTokenRequest : OAuthTokenRequest {
    
    open let facebookToken :String
    
    public init(authDomain: String, clientId: String, clientSecret: String, scope: [String], facebookToken : String, accessType : OauthAccessType? = nil) {
        
        self.facebookToken = facebookToken
        
        super.init(authDomain: authDomain, grantType: .facebookToken, clientId: clientId, clientSecret: clientSecret, scope: scope)
        
        self.accessType = accessType
    }
    
    override open func getRequestParam() -> [String : Any] {
       
        var param = super.getRequestParam()

        param[OauthParamName.facebookToken] = self.facebookToken
        
        return param
    }
}

