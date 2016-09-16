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
    
    open func getRequestParam() -> [String: AnyObject]{
        
        var param : [String : AnyObject] = [:]
        
        param[OauthParamName.GRANT_TYPE] = self.grantType.rawValue as AnyObject?
        param[OauthParamName.CLIENT_ID] = self.clientId as AnyObject?
        param[OauthParamName.CLIENT_SECRET] = self.clientSecret as AnyObject?
        
        if let scope = self.scope{
            param[OauthParamName.SCOPE] = scope.joined(separator: " ") as AnyObject?
        }
        
        if let accessType = self.accessType{
            param[OauthParamName.ACCESS_TYPE] = accessType.rawValue as AnyObject?
        }

        return param
    }
}

