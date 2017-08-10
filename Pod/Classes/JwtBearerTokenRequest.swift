//
//  JwtBearerTokenRequest.swift
//  Pods
//
//  Created by Karthik on 7/7/17.
//
//

import UIKit

open class JwtBearerTokenRequest: OAuthTokenRequest {
    
    open let jwt: String
    
    public init(authDomain: String, jwt: String) {
        
        self.jwt = jwt
        
        super.init(authDomain: authDomain, grantType: .JWT_BEARER, clientId: "", clientSecret: "")
    }
    
    open override func getRequestParam() -> [String : Any] {
        
        var param = super.getRequestParam()
        
        param[OauthParamName.JWT] = jwt
        
        return param
    }
}
