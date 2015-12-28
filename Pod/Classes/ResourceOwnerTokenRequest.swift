//
//  ResourceOwnerTokenRequest.swift
//  Pods
//
//  Created by Karthik on 24/12/15.
//
//

import UIKit

public class ResourceOwnerTokenRequest : OAuthTokenRequest{
    
   public let userName : String
    
   public let password : String
    
   public init(authDomain: String, clientId: String, clientSecret: String, scope: [String],userName : String,password :String,accessType :OauthAccessType? = nil) {
        
        self.userName = userName
        
        self.password = password
    
        super.init(authDomain: authDomain, grantType: OauthGrantType.PASSWORD, clientId: clientId, clientSecret: clientSecret, scope: scope)
        
        self.accessType = accessType
    }
    
    override public func getRequestParam() -> [String : AnyObject] {
        
        var param = super.getRequestParam()
        
        param[OauthParamName.USERNAME] = self.userName
        param[OauthParamName.PASSWORD] = self.password
        
        return param
    }
}

