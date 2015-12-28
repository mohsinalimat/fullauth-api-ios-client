//
//  FacebookTokenRequest.swift
//  Pods
//
//  Created by Karthik on 24/12/15.
//
//

import UIKit

public class FacebookTokenRequest : OAuthTokenRequest {
    
    public let facebookToken :String
    
    public init(authDomain: String, clientId: String, clientSecret: String, scope: [String],facebookToken : String, accessType : OauthAccessType? = nil) {
        
        self.facebookToken = facebookToken
        
        super.init(authDomain: authDomain, grantType: OauthGrantType.FACEBOOK_TOKEN, clientId: clientId, clientSecret: clientSecret, scope: scope)
        
        self.accessType = accessType
    }
    
    
    override public func getRequestParam() -> [String : AnyObject] {
       
        var param = super.getRequestParam()

        param[OauthParamName.FACEBOOK_TOKEN] = self.facebookToken
        
        return param
    }
}

