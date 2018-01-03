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
    
    public init(authDomain: String, clientId: String, scopes: [String], accessType: OauthAccessType = .offline) {
        
        self.authDomain = authDomain
        self.clientId = clientId
        self.scopes = scopes
        self.accessType = accessType
    }
    
    public func getAuthCodeUrl(withRedirectUrl redirectUrl: String) throws -> URL {
        
        let oauthObj = FullAuthOAuthService(authDomain: self.authDomain)
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

