//
//  FullAuthOAuthService+Validation.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit


extension FullAuthOAuthService {
    
    func validateAccessToken(accesstoken: String, tokenType: AccessTokenType) throws {
        
        guard !accesstoken.isEmpty else{
            throw OAuthError.illegalParameter("invalid \(AccessTokenType.getAccessToken(forType: tokenType))")
        }
    }
    
    func validateOauthClientId() throws {
        
        guard let clientid = clientId, !clientid.isEmpty else {
            throw OAuthError.errorCode(.invalidClient)
        }
    }

    func validateOauthClient() throws {
        
        guard let clientid = clientId, !clientid.isEmpty else {
            throw OAuthError.errorCode(.invalidClient)
        }
        
        guard let clientsecret = clientSecret, !clientsecret.isEmpty else {
            throw OAuthError.errorCode(.invalidClientSecret)
        }
    }
    
    func validateOauthDomain() throws {
        
        guard !self.authDomain.isEmpty else{
            throw OAuthError.errorCode(.invalidDomain)
        }
    }
    
    func validateScope(_ scope :[String]) throws {
        
        guard !scope.isEmpty else{
            throw OAuthError.errorCode(.invalidScope)
        }
    }
    
    func validateAccessType(_ accessType :String) throws {
        
        guard !accessType.isEmpty else{
            throw OAuthError.errorCode(.invalidAccessType)
        }
    }
}

