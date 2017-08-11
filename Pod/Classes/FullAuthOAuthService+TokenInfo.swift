//
//  FullAuthOAuthService+TokenInfo.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit
import Alamofire



//MARK: GET TOKEN INFO
extension FullAuthOAuthService {

    
    open func getTokenInfo(_ accessToken : String, handler : TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateAccessToken(accesstoken: accessToken, tokenType: .DEFAULT)
        
        fetchAccessTokenInfo(authDomain, accessToken: accessToken, handler: handler)
    }
    
    internal func fetchAccessTokenInfo(_ authDomain : String,accessToken:String,handler : TokenInfoHandler?){
        
        //TODO: Check
        let url = Foundation.URL(string: Constants.OAuth.getTokenUrl(authDomain))
        var request = URLRequest(url:url!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = timeOutInterval
        
        let parameter = [OauthParamName.ACCESS_TOKEN:accessToken]
        
        do{
            let urlRequest = try URLEncoding.queryString.encode(request, with: parameter)
            
            makeRequest(urlRequest) { (success, httpRequest, httpResponse, responseJson, error) -> Void in
                
                self.handleTokenResponse(success, respJson: responseJson, error: error, handler: handler)
            }
            
        }catch let error as NSError{
            self.handleTokenResponse(false, respJson: nil, error: error, handler: handler)
        }
    }
}
    
