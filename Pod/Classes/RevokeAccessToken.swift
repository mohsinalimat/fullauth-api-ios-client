//
//  RevokeAccessToken.swift
//  Pods
//
//  Created by Karthik on 4/20/17.
//
//

import Foundation
import Alamofire

extension FullAuthOAuthService {
    
    open func revokeAccessToken(accessToken: String, handler: revokeTokenHandler?) throws{
        
        try validateOauthDomain()
        
        try validateAccessToken(accesstoken: accessToken, tokenType: .defaultToken)
        
        try revokeAccessToken(authDomain, accessToken: accessToken, handler: handler)
    }
    
    
    internal func revokeAccessToken(_ authDomain: String, accessToken: String, handler: revokeTokenHandler?) throws{
        
        guard let url = URL(string: Constants.OAuth.getRevokeTokenUrl(authDomain: authDomain)) else {
            throw OAuthError.illegalParameter("Invalid url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = timeOutInterval
        
        let parameter = ["token": accessToken]
        
        do{
            
            let urlRequest = try URLEncoding.queryString.encode(request, with: parameter)
            
            makeRequest(urlRequest) { (success, httpRequest, httpResponse, responseJson, error) in
                
                guard !success else{
                    handler?(true, nil, nil)
                    return
                }
                
                var errorResp : OAuthTokenErrorResponse?
                
                if let respJson = responseJson {
                    errorResp = OAuthTokenErrorResponse(data: respJson)
                }
                
                handler?(false, error, errorResp)
            }
            
        }catch let error as Error{
            handler?(false, error, nil)
        }
    }
    
}
