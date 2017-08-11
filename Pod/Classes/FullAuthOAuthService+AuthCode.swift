//
//  FullAuthOAuthService+AuthCode.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit


public struct AuthCodeRequest {
    
    public let authDomain: String
    
    public let clientId: String
    
    public let scopes: [String]
    
    public let accessType : OauthAccessType
    
    public init(authDomain: String, clientId: String, scopes: [String], accessType: OauthAccessType) {
        
        self.authDomain = authDomain
        self.clientId = clientId
        self.scopes = scopes
        self.accessType = accessType
    }
}

