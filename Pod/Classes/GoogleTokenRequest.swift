//
//  GoogleTokenRequest.swift
//  Pods
//
//  Created by Karthik on 23/12/15.
//
//

import UIKit

open class GoogleTokenRequest: OAuthTokenRequest {

    open let googleToken :String
    
    public init(authDomain : String,
                clientId : String,
                clientSecret :String,
                scope : [String],
                googleToken : String,
                accessType : OauthAccessType? = nil){
    
        self.googleToken = googleToken
        
        super.init(authDomain: authDomain, grantType: OauthGrantType.GOOGLE_TOKEN, clientId: clientId, clientSecret: clientSecret, scope: scope)

        self.accessType = accessType
    }
    
    override open func getRequestParam() -> [String : Any] {
        
        var param = super.getRequestParam()
        
        param[OauthParamName.GOOGLE_TOKEN] = self.googleToken
        
        return param
    }
}
