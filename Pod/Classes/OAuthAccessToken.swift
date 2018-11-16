//
//  OauthAccessToken.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit

public struct OAuthAccessToken {
    
    public var accessToken : String
    
    public var tokenType : String
    
    public var expiresIn : Int
    
    public var userId :String?
    
    public var issuedTo : String?
    
    public var refreshToken : String?
    
    public var scopes : [String]?
    
    public var accessType :OauthAccessType?
    
    public var expires: Int?
    
    public init(data : [String : Any?]) {
        
        self.accessToken = data[OauthParamName.ACCESS_TOKEN] as! String
        
        self.expiresIn = data["expires_in"] as! Int
        
        self.tokenType = data["token_type"] as! String
        
        if let id = data["user_id"] as? String {
            self.userId = id
        }
        
        if let issuedTo = data["issued_to"] as? String {
            self.issuedTo = issuedTo
        }
        
        if let scope = data["scopes"] as? [String] {
            self.scopes = scope
        }
        
        if let refresh_token = data[OauthParamName.REFRESH_TOKEN] as? String {
            self.refreshToken = refresh_token
        }
        
        if let accessTypeString = data[OauthParamName.ACCESS_TYPE] as? String {
            self.accessType = OauthAccessType.getType(accessType: accessTypeString)
        }
        
        if let expiresInMillis = data["expires"] as? Int {
            self.expires = expiresInMillis
        }
    }
}
