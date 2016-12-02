//
//  FullAuthOAuthService+RefreshToken.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit


extension FullAuthOAuthService {
    
    
    //MARK: REFRESH ACCESS TOKEN
    open func refreshAccessToken(_ refreshToken  : String,expiryType : OauthExpiryType? = nil, handler : TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateOauthClient()
        
        try validateAccessToken(accesstoken: refreshToken, tokenType: .REFRESH)
        
        let request = RefreshTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, refreshToken: refreshToken, expiryType: expiryType)
        
        makeTokenRequest(request, handler: handler)
    }
}
