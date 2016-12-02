//
//  FullAuthOAuthService+Request.swift
//  Pods
//
//  Created by Karthik on 01/12/16.
//
//

import UIKit
import Alamofire


//MARK: UTILS
extension FullAuthOAuthService {
    
    open func makeRequest(_ urlRequest : URLRequestConvertible, handler : ApiResponseHandler?){
        
        //TODO: Check
        let request = Alamofire.request(urlRequest)
        
        request.responseJSON { (response) -> Void in
            
            if handler != nil {
                
                let error = response.result.error
                
                let statusCode = response.response?.statusCode
                
                let success :Bool = (response.result.isSuccess && statusCode! >= 200 && statusCode! <= 299)
                
                let jsonDict = response.result.value as? [String: AnyObject]
                
                handler?(success, response.request, response.response, jsonDict , error as? NSError)
            }
        }
    }
    
    open func handleTokenResponse(_ success : Bool, respJson :[String : AnyObject?]?,error : NSError?, handler : TokenInfoHandler?){
        
        if handler != nil{
            
            guard !success else {
                handler?(nil,nil, OAuthAccessToken(data: respJson!))
                return
            }
            
            var errorResp : OAuthTokenErrorResponse?
            
            if respJson != nil {
                errorResp = OAuthTokenErrorResponse(data: respJson!)
            }
            
            handler?(error, errorResp, nil)
        }
    }
    
    open func makeTokenRequest(_ tokenRequest : OAuthTokenRequest,handler : TokenInfoHandler?){
        
        //TODO: Check
        let url = Foundation.URL(string: Constants.OAuth.getTokenUrl(tokenRequest.authDomain))
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.timeoutInterval = timeOutInterval
        
        let parameter = tokenRequest.getRequestParam()
        
        do{
            let urlRequest = try URLEncoding.httpBody.encode(request, with: parameter)
            
            makeRequest(urlRequest) { (success, httpRequest, httpResponse, responseJson, error) -> Void in
                
                self.handleTokenResponse(success, respJson: responseJson, error: error, handler: handler)
            }
            
        }catch let error as NSError{
            self.handleTokenResponse(false, respJson: nil, error: error, handler: handler)
        }
    }
}

