//
//  OauthTokenRequest.swift
//  Pods
//
//  Created by Karthik on 23/12/15.
//
//

import UIKit
import Alamofire

open class OAuthTokenRequest {
    
    let authDomain : String

    let grantType : OauthGrantType
    
    let clientId: String
    
    let clientSecret : String
        
    var scope : [String]?
    
    var accessType : OauthAccessType?
    
    
    public init(authDomain : String, grantType : OauthGrantType, clientId : String, clientSecret :String,scope : [String]? = nil){
        
        self.authDomain = authDomain
        
        self.grantType = grantType
        
        self.clientId = clientId
        
        self.clientSecret = clientSecret

        self.scope = scope
    }
    
    open func getRequestParam() -> [String: Any]{
        
        var param : [String : Any] = [:]
        
        param[OauthParamName.grantType] = self.grantType.rawValue
        param[OauthParamName.clientId] = self.clientId
        param[OauthParamName.clientSecret] = self.clientSecret
        
        if let scope = self.scope {
            param[OauthParamName.scope] = scope.joined(separator: " ")
        }
        
        if let accessType = self.accessType{
            param[OauthParamName.accessType] = accessType.rawValue
        }

        return param
    }
}

