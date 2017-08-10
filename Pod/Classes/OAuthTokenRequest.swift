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
        
        var param : [String: Any] = [:]
        
        param[OauthParamName.GRANT_TYPE] = self.grantType.rawValue
        
        if !self.clientId.isEmpty {
            param[OauthParamName.CLIENT_ID] = self.clientId
        }
        
        if !self.clientSecret.isEmpty {
            param[OauthParamName.CLIENT_SECRET] = self.clientSecret
        }
        
        if let scope = self.scope {
            param[OauthParamName.SCOPE] = scope.joined(separator: " ")
        }
        
        if let accessType = self.accessType {
            param[OauthParamName.ACCESS_TYPE] = accessType.rawValue
        }

        return param
    }
}

