
import UIKit
import Alamofire
import Foundation

open class FullAuthOAuthService {
    
    let authDomain : String!
    
    var clientId : String?
    
    var clientSecret : String?
    
    open var timeOutInterval : TimeInterval = 60
    
    
    public typealias ApiResponseHandler = (_ success : Bool, _ httpRequest : URLRequest?, _ httpResponse :  HTTPURLResponse?, _ responseJson : [String : AnyObject?]?, _ error : NSError?) -> Void
    
    
    public typealias TokenInfoHandler = (_ error : NSError?,_ errorResponse : OAuthTokenErrorResponse?,_ accessToken : OAuthAccessToken?) -> Void
    
    public typealias revokeTokenHandler = (_ success: Bool, _ error : NSError?,_ errorResponse : OAuthTokenErrorResponse?) -> Void
    
    
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
    open func requestAccessTokenForResourceCredentials(_ userName : String,password : String, scope :[String],accessType : OauthAccessType? = nil, handler : TokenInfoHandler?) throws{
        
        try self.validateOauthDomain()
        
        try self.validateOauthClient()
        
        try self.validateScope(scope)
        
        guard !Utils.isNilOrEmptyStr(userName) else{
            throw OAuthError.illegalParameter("invalid userName")
        }
        
        guard !Utils.isNilOrEmptyStr(password) else{
            throw OAuthError.illegalParameter("invalid password")
        }
        
        let request = ResourceOwnerTokenRequest(authDomain: authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, scope: scope, userName: userName, password: password, accessType: accessType)
        
        makeTokenRequest(request, handler: handler)
    }
    
    
    //MARK:REQUEST ACCESS FOR GOOGLE TOKEN
    open func requestAccessTokenForGoogleToken(googleAccessToken : String, scope : [String],accessType : OauthAccessType? = nil, handler : TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateOauthClient()
        
        try validateAccessToken(accesstoken: googleAccessToken, tokenType: .GOOGLE)
        
        try validateScope(scope)
        
        let request =  GoogleTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, scope: scope, googleToken: googleAccessToken, accessType: accessType)
        
        self.makeTokenRequest(request,handler: handler)
    }
    
    //MARK:REQUEST ACCESS FOR FACEBOOK TOKEN
    open func requestAccessTokenForFacebookToken(facebookAccessToken : String, scope : [String],accessType : OauthAccessType? = nil, handler : TokenInfoHandler?) throws{
        
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
        
        let params = tokenRequest.getRequestParam()
        
        let URL = Foundation.URL(string: Constants.OAuth.getTokenUrl(tokenRequest.authDomain))
        
        let mutableURLRequest = NSMutableURLRequest(url:URL!)
        

        mutableURLRequest.httpMethod = HTTPMethod.post.rawValue
        mutableURLRequest.timeoutInterval = timeOutInterval
        
//        let urlRequest =  ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
//        
//        makeRequest(urlRequest) { (success, httpRequest, httpResponse, responseJson, error) -> Void in
//            
//            self.handleTokenResponse(success, respJson: responseJson, error: error, handler: handler)
//        }
    }
    
    internal func fetchAccessTokenInfo(_ authDomain : String,accessToken:String,handler : TokenInfoHandler?){
        
        let URL = Foundation.URL(string: Constants.OAuth.getTokenUrl(authDomain))
            
        let mutableURLRequest = NSMutableURLRequest(url:URL!)
        mutableURLRequest.httpMethod = HTTPMethod.get.rawValue
        mutableURLRequest.timeoutInterval = timeOutInterval
        
        let param = [OauthParamName.ACCESS_TOKEN:accessToken]
        
//        let urlRequest =  ParameterEncoding.URL.encode(mutableURLRequest, parameters: param).0
//        
//        makeRequest(urlRequest) { (success, httpRequest, httpResponse, responseJson, error) -> Void in
//            
//            self.handleTokenResponse(success, respJson: responseJson, error: error, handler: handler)
//        }
    }
    
    
    internal func revokeAccessToken(_ authDomain: String, accessToken: String,handler: revokeTokenHandler?){
        
        let URL = Foundation.URL(string: Constants.OAuth.getRevokeTokenUrl(authDomain: authDomain))
        
        let mutableRequest = NSMutableURLRequest(url: URL!)
        mutableRequest.httpMethod = HTTPMethod.get.rawValue
        mutableRequest.timeoutInterval = timeOutInterval
        
        let param = ["token": accessToken]
        
//        let urlRequest = ParameterEncoding.URL.encode(mutableRequest, parameters: param).0
//        
//        makeRequest(urlRequest) { (success, httpRequest, httpResponse, responseJson, error) in
//        
//            if success{
//                
//                handler!(success: true, error:nil, errorResponse: nil)
//                return
//            }
//            
//            var errorResp : OAuthTokenErrorResponse?
//            
//            if responseJson != nil {
//                
//                errorResp = OAuthTokenErrorResponse(data: responseJson!)
//            }
//            
//            handler!(success: false, error:error, errorResponse: errorResp)
//        }
    }
    
    
    //MARK: UTILS
    open func makeRequest(_ urlRequest : URLRequestConvertible, handler : ApiResponseHandler?){
        
        let request = Alamofire.request(urlRequest)
        
        request.responseJSON { (response) -> Void in
            
            if handler != nil {
                
                let error = response.result.error
                
                let statusCode = response.response?.statusCode
                
                //TODO: Check
                let success :Bool = (response.result.isSuccess && statusCode! >= 200 && statusCode! <= 299)
                
                let jsonDict = response.result.value as? [String: AnyObject]
                
                handler?(success, response.request, response.response, jsonDict , error as? NSError)
            }
        }
    }
    
    open func handleTokenResponse(_ success : Bool, respJson :[String : AnyObject?]?,error : NSError?, handler : TokenInfoHandler?){
        
        if handler != nil{
            
            if success {
                
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

