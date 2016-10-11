
import UIKit
import Alamofire
import Foundation

open class FullAuthOAuthService {
    
    let authDomain : String!
    
    var clientId : String?
    
    var clientSecret : String?
    
    open var timeOutInterval : TimeInterval = 60
    
    public typealias ApiResponseHandler = (_ success : Bool,_ httpRequest : URLRequest?,_ httpResponse :  HTTPURLResponse?,_ responseJson : [String : AnyObject?]?,_ error : NSError?) -> Void
    
    public typealias TokenInfoHandler = (_ error : NSError?,_ errorResponse : OAuthTokenErrorResponse?,_ accessToken : OAuthAccessToken?) -> Void
    
    public typealias revokeTokenHandler = (_ success: Bool,_ error : NSError?,_ errorResponse : OAuthTokenErrorResponse?) -> Void
    
    
    public init(authDomain : String,clientId :String? = nil,clientSecret : String? = nil){
        
        self.authDomain = authDomain
        
        if let clientId = clientId{
            self.clientId = clientId
        }
        
        if let clientSecret = clientSecret{
            self.clientSecret = clientSecret
        }
    }
    
    
    //MARK: GET TOKEN INFO
    open func getTokenInfo(_ accessToken : String, handler : TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateAccessToken(accesstoken: accessToken, tokenType: .DEFAULT)
        
        fetchAccessTokenInfo(authDomain, accessToken: accessToken, handler: handler)
    }
    
    
    //MARK: REFRESH ACCESS TOKEN
    open func refreshAccessToken(_ refreshToken  : String,expiryType : OauthExpiryType? = nil, handler : TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateOauthClient()
            
        try validateAccessToken(accesstoken: refreshToken, tokenType: .REFRESH)
        
        let request = RefreshTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, refreshToken: refreshToken, expiryType: expiryType)
        
        makeTokenRequest(request, handler: handler)
    }
    
    //MARK:REQUEST ACCESS FOR USERNAME AND PASSWORD
    open func requestAccessTokenForResourceCredentials(_ userName : String,
                                                       password : String,
                                                       scope :[String],
                                                       accessType : OauthAccessType? = nil,
                                                       handler : TokenInfoHandler?) throws{
        
        try self.validateOauthDomain()
        
        try self.validateOauthClient()
        
        try self.validateScope(scope)
        
        guard !Utils.isNilOrEmptyStr(userName) else{
            throw OAuthError.illegalParameter("invalid userName")
        }
        
        guard !Utils.isNilOrEmptyStr(password) else{
            throw OAuthError.illegalParameter("invalid password")
        }
        
        let request = ResourceOwnerTokenRequest(authDomain: authDomain,
                                                clientId: self.clientId!,
                                                clientSecret: self.clientSecret!,
                                                scope: scope, userName: userName,
                                                password: password,
                                                accessType: accessType)
        
        makeTokenRequest(request, handler: handler)
    }
    
    
    //MARK:REQUEST ACCESS FOR GOOGLE TOKEN
    open func requestAccessTokenForGoogleToken(googleAccessToken : String,
                                               scope : [String],
                                               accessType : OauthAccessType? = nil,
                                               handler : TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateOauthClient()
        
        try validateAccessToken(accesstoken: googleAccessToken, tokenType: .GOOGLE)
        
        try validateScope(scope)
        
        let request =  GoogleTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, scope: scope, googleToken: googleAccessToken, accessType: accessType)
        
        self.makeTokenRequest(request,handler: handler)
    }
    
    //MARK:REQUEST ACCESS FOR FACEBOOK TOKEN
    open func requestAccessTokenForFacebookToken(facebookAccessToken : String,
                                                 scope : [String],
                                                 accessType : OauthAccessType? = nil,
                                                 handler : TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateAccessToken(accesstoken: facebookAccessToken, tokenType: .FACEBOOK)
        
        try validateOauthClient()
        
        try validateScope(scope)
        
        let request = FacebookTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, scope: scope, facebookToken: facebookAccessToken, accessType: accessType)
        
        makeTokenRequest(request, handler: handler)
    }
    
    
    //MARK:REVOKE ACCESS TOKEN
    open func revokeAccessToken(accessToken: String, handler: revokeTokenHandler?) throws{
        
        try validateOauthDomain()
        
        try validateAccessToken(accesstoken: accessToken, tokenType: .DEFAULT)
        
        revokeAccessToken(authDomain, accessToken: accessToken, handler: handler)
    }
    
    
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
    
    
    //MARK: MAKE REQUESTS
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
    
    
    internal func revokeAccessToken(_ authDomain: String, accessToken: String,handler: revokeTokenHandler?){
        
        //TODO: Check
        let url = Foundation.URL(string: Constants.OAuth.getRevokeTokenUrl(authDomain: authDomain))
        
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
    
    
    //MARK: UTILS
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
}

