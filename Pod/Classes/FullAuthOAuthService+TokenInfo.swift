//
//  FullAuthOAuthService+TokenInfo.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit
import Alamofire

extension FullAuthOAuthService {
    
    open func getTokenInfo(_ accessToken: String, handler: TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateAccessToken(accesstoken: accessToken, tokenType: .defaultToken)
        
        try fetchAccessTokenInfo(authDomain, accessToken: accessToken, handler: handler)
    }
    
    internal func fetchAccessTokenInfo(_ authDomain : String, accessToken: String, handler : TokenInfoHandler?) throws{
        
        guard let url = URL(string: Constants.OAuth.getTokenUrl(self.liveMode, authDomain)) else {
            throw OAuthError.illegalParameter("Invalid url")
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = timeOutInterval
        
        let parameter = [OauthParamName.accessToken: accessToken]
        
        do{
            let urlRequest = try URLEncoding.queryString.encode(request, with: parameter)
            
            makeRequest(urlRequest) { (success, httpRequest, httpResponse, responseJson, error) -> Void in
                self.handleTokenResponse(success, respJson: responseJson, error: error, handler: handler)
            }
            
        }catch let error as Error{
            self.handleTokenResponse(false, respJson: nil, error: error, handler: handler)
        }
    }
}
    
