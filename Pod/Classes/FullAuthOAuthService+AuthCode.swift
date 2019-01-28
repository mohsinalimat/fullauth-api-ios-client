//
//  FullAuthOAuthService+AuthCode.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit

/* To present Auth page in view controller, user this url
 */
public struct AuthCodeRequest {
    
    public let authDomain: String
    
    public let clientId: String
    
    public let scopes: [String]
    
    public let accessType : OauthAccessType
    
    public let liveMode: Bool
    
    public var isCustomURL: Bool = false
    
    public init(liveMode: Bool = true, authDomain: String, clientId: String, scopes: [String], accessType: OauthAccessType = .offline) {
        
        self.liveMode = liveMode
        self.authDomain = authDomain
        self.clientId = clientId
        self.scopes = scopes
        self.accessType = accessType
    }
    
    public init(liveMode: Bool = true, authDomain: String, clientId: String, scopes: [String], accessType: OauthAccessType = .offline, isCustomURL: Bool) {
        
        self.init(liveMode: liveMode, authDomain: authDomain, clientId: clientId, scopes: scopes, accessType: accessType)
        self.isCustomURL = isCustomURL
    }
    
    
    public func getAuthCodeUrl(withRedirectUrl redirectUrl: String) throws -> URL {
        
        let oauthObj = FullAuthOAuthService(liveMode: liveMode, isCustomURL: isCustomURL, authDomain: authDomain)
        
        oauthObj.clientId = self.clientId
        
        do {
            
            let urlStr = try oauthObj.getAuthCodeUrl(scopes: self.scopes, redirectUrl: redirectUrl)
            
            guard var url = URL(string: urlStr) else {
                throw OAuthError.errorCode(.requestFailed)
            }
            
            return url
            
        } catch let err {
            throw OAuthError.error(err)
        }
    }
} 

