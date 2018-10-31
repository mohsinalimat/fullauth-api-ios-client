//
//  FullAuthOAuthService+Request.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit
import Alamofire

extension FullAuthOAuthService {
    
    open func makeTokenRequest(_ tokenRequest: OAuthTokenRequest, handler: TokenInfoHandler?) throws{
        
        guard let url = URL(string: Constants.OAuth.getTokenUrl(self.liveMode, tokenRequest.authDomain)) else {
            throw OAuthError.illegalParameter("invalid url to make request")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.timeoutInterval = timeOutInterval
        
        let parameter = tokenRequest.getRequestParam()
        
        do{
            let urlRequest = try URLEncoding.httpBody.encode(request, with: parameter)
            
            makeRequest(urlRequest, handler: { (success, httpRequest, httpResponse, responseJson, error) in
                
                self.handleTokenResponse(success, respJson: responseJson, error: error, handler: handler)
            })
            
        }catch let error as Error {
            self.handleTokenResponse(false, respJson: nil, error: error, handler: handler)
        }
    }
    
    open func makeRequest(_ urlRequest : URLRequestConvertible, handler : ApiResponseHandler?){
        
        let request = Alamofire.request(urlRequest)
        
        request.responseJSON { (response) -> Void in
            
            if handler != nil {
                
                let error = response.result.error
                
                let statusCode = response.response?.statusCode
                
                let success: Bool = (response.result.isSuccess && statusCode! >= 200 && statusCode! <= 299)
                
                let jsonDict = response.result.value as? [String: Any]
                
                handler?(success, response.request, response.response, jsonDict , error)
            }
        }
    }
    
    open func handleTokenResponse(_ success : Bool, respJson :[String : Any?]?, error : Error?, handler : TokenInfoHandler?){
        
        guard !success else {
            handler?(nil,nil, OAuthAccessToken(data: respJson!))
            return
        }
        
        var errorResp : OAuthTokenErrorResponse?
        
        if let resp = respJson {
            errorResp = OAuthTokenErrorResponse(data: resp)
        }
        
        handler?(error, errorResp, nil)
    }
}

