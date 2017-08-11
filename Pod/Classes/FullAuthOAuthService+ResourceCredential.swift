//
//  FullAuthOAuthService+ResourceCredential.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit


//MARK:REQUEST ACCESS FOR USERNAME AND PASSWORD
extension FullAuthOAuthService {
    
    
//    open func requestAccessTokenForResourceCredentials(_ userName : String,
//                                                       password : String,
//                                                       scope :[String],
//                                                       accessType : OauthAccessType? = nil,
//                                                       handler : TokenInfoHandler?) throws{
//        
//        try self.validateOauthDomain()
//        
//        try self.validateOauthClient()
//        
//        try self.validateScope(scope)
//        
//        guard !Utils.isNilOrEmptyStr(userName) else{
//            throw OAuthError.illegalParameter("invalid userName")
//        }
//        
//        guard !Utils.isNilOrEmptyStr(password) else{
//            throw OAuthError.illegalParameter("invalid password")
//        }
//        
//        let request = ResourceOwnerTokenRequest(authDomain: authDomain,
//                                                clientId: self.clientId!,
//                                                clientSecret: self.clientSecret!,
//                                                scope: scope, userName: userName,
//                                                password: password,
//                                                accessType: accessType)
//        
//        makeTokenRequest(request, handler: handler)
//    }
    
    open func requestAccessTokenForResourceCredentials(_ userName: String, password: String,scope: [String], accessType : OauthAccessType? = nil, handler : TokenInfoHandler?) throws{
        
        try self.validateOauthDomain()
        
        try self.validateOauthClient()
        
        try self.validateScope(scope)
        
        guard !userName.isEmpty else {
            throw OAuthError.illegalParameter("invalid userName")
        }
        
        guard !password.isEmpty else {
            throw OAuthError.illegalParameter("invalid password")
        }
        
        let request = ResourceOwnerTokenRequest(authDomain: authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, scope: scope, userName: userName, password: password, accessType: accessType)
        
        try makeTokenRequest(request, handler: handler)
    }
}
