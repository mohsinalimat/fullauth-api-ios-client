//
//  FullAuthOAuthService+GoogleToken.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit

//MARK:REQUEST ACCESS FOR GOOGLE TOKEN
extension FullAuthOAuthService {
    
    open func requestAccessTokenForGoogleToken(googleAccessToken : String, scope : [String], accessType : OauthAccessType? = nil, handler : TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateOauthClient()
        
        try validateAccessToken(accesstoken: googleAccessToken, tokenType: .googleToken)
        
        try validateScope(scope)
        
        let request =  GoogleTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, scope: scope, googleToken: googleAccessToken, accessType: accessType)
        
        try self.makeTokenRequest(request,handler: handler)
    }
}
