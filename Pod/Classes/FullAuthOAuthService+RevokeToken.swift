//
//  FullAuthOAuthService+RevokeToken.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit
import Alamofire

//MARK:REVOKE ACCESS TOKEN
extension FullAuthOAuthService {
    
    open func revokeAccessToken(accessToken: String, handler: revokeTokenHandler?) throws{
        
        try validateOauthDomain()
        
        try validateAccessToken(accesstoken: accessToken, tokenType: .defaultToken)
        
        revokeToken(authDomain, accessToken: accessToken, handler: handler)
    }
    
    
    internal func revokeToken(_ authDomain: String, accessToken: String,handler: revokeTokenHandler?){
        
        let url = Foundation.URL(string: Constants.OAuth.getRevokeTokenUrl(self.liveMode, authDomain: authDomain))
        
        var request = URLRequest(url: url!)
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
                
                if responseJson != nil {
                    
                    errorResp = OAuthTokenErrorResponse(data: responseJson!)
                }
                
                handler?(false, error, errorResp)
            }
            
        }catch let error as NSError{
            handler?(false, error, nil)
        }
    }
}
