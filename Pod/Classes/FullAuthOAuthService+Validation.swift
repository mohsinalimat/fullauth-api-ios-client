//
//  FullAuthOAuthService+Validation.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit


extension FullAuthOAuthService {
    
    //MARK: VALIDATION UTILS
    func validateAccessToken(accesstoken: String, tokenType: AccessTokenType) throws {
        
        guard !accesstoken.isEmpty else{
            throw OAuthError.illegalParameter("invalid \(AccessTokenType.getAccessTokenString(tokenType))")
        }
    }
    
    func validateOauthClient() throws{
        
        guard !Utils.isNilOrEmptyStr(clientId) else{
            throw OAuthError.illegalParameter("invalid clientId")
        }
        
        guard !Utils.isNilOrEmptyStr(clientSecret) else{
            throw OAuthError.illegalParameter("invalid clientSecret")
        }
    }
    
    func validateOauthDomain() throws{
        
        guard !self.authDomain.isEmpty else{
            throw OAuthError.illegalParameter("invalid sub domain")
        }
    }
    
    func validateScope(_ scope :[String]) throws{
        
        guard !scope.isEmpty else{
            throw OAuthError.illegalParameter("invalid scope")
        }
    }
    
    func validateAccessType(_ accessType :String) throws{
        
        guard !accessType.isEmpty else{
            throw OAuthError.illegalParameter("invalid accessType")
        }
    }
}
