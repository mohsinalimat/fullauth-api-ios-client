
import UIKit
import Alamofire
import Foundation

public class FullAuthOAuthService {
    
    let authDomain : String!
    
    var clientId : String?
    
    var clientSecret : String?
    
    public var timeOutInterval : NSTimeInterval = 60
    
    
    public typealias ApiResponseHandler = (success : Bool, httpRequest : NSURLRequest?, httpResponse :  NSHTTPURLResponse?, responseJson : [String : AnyObject?]?, error : NSError?) -> Void
    
    
    public typealias TokenInfoHandler = (error : NSError?,errorResponse : OAuthTokenErrorResponse?,accessToken : OAuthAccessToken?) -> Void
    
    
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
    public func getTokenInfo(accessToken : String, handler : TokenInfoHandler?) throws{
        
        try self.validateOauthDomain()
        
        guard !accessToken.isEmpty else{
            
            throw OAuthError.IllegalParameter("invalid access token")
        }
        
        self.fetchAccessTokenInfo(authDomain, accessToken: accessToken, handler: handler)
    }
    
    
    
    //MARK: REFRESH ACCESS TOKEN
    public func refreshAccessToken(refreshToken  : String,expiryType : OauthExpiryType? = nil, handler : TokenInfoHandler?) throws{
        
        try self.validateOauthDomain()
        
        try self.validateOauthClient()
        
        guard !refreshToken.isEmpty else{
            throw OAuthError.IllegalParameter("invalid refresh token")
        }
        
        let request = RefreshTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, refreshToken: refreshToken, expiryType: expiryType)
        
        self.makeTokenRequest(request, handler: handler)
    }
    
    //MARK:REQUEST ACCESS FOR USERNAME AND PASSWORD
    public func requestAccessTokenForResourceCredentials(userName : String,password : String, scope :[String],accessType : OauthAccessType? = nil, handler : TokenInfoHandler?) throws{
        
        try self.validateOauthDomain()
        
        try self.validateOauthClient()
        
        try self.validateScope(scope)
        
        guard !Utils.isNilOrEmptyStr(userName) else{
            throw OAuthError.IllegalParameter("invalid userName")
        }
        
        guard !Utils.isNilOrEmptyStr(password) else{
            throw OAuthError.IllegalParameter("invalid password")
        }
        
        let request = ResourceOwnerTokenRequest(authDomain: authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, scope: scope, userName: userName, password: password, accessType: accessType)
        
        self.makeTokenRequest(request, handler: handler)
    }
    
    
    //MARK:REQUEST ACCESS FOR GOOGLE TOKEN
    public func requestAccessTokenForGoogleToken(googleAccessToken googleAccessToken : String, scope : [String],accessType : OauthAccessType? = nil, handler : TokenInfoHandler?) throws{
        
        try self.validateOauthDomain()
        
        try self.validateOauthClient()
        
        guard !googleAccessToken.isEmpty else{
            throw OAuthError.IllegalParameter("invalid google access token")
        }
        
        try self.validateScope(scope)
        
        let request =  GoogleTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, scope: scope, googleToken: googleAccessToken, accessType: accessType)
        
        self.makeTokenRequest(request,handler: handler)
    }
    
    //MARK:REQUEST ACCESS FOR FACEBOOK TOKEN
    public func requestAccessTokenForFacebookToken(facebookAccessToken facebookAccessToken : String, scope : [String],accessType : OauthAccessType? = nil, handler : TokenInfoHandler?) throws{
        
        try self.validateOauthDomain()
        
        guard !facebookAccessToken.isEmpty else{
            
            throw OAuthError.IllegalParameter("invalid facebook access token")
        }
        
        try self.validateOauthClient()
        
        try self.validateScope(scope)
        
        let request = FacebookTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, scope: scope, facebookToken: facebookAccessToken, accessType: accessType)
        
        self.makeTokenRequest(request, handler: handler)
    }
    
    
    //MARK: VALIDATION UTILS
    func validateOauthClient() throws{
        
        guard !Utils.isNilOrEmptyStr(clientId) else{
            throw OAuthError.IllegalParameter("invalid clientId")
        }
        
        guard !Utils.isNilOrEmptyStr(clientSecret) else{
            throw OAuthError.IllegalParameter("invalid clientSecret")
        }
    }
    
    func validateOauthDomain() throws{
        
        guard !self.authDomain.isEmpty else{
            throw OAuthError.IllegalParameter("invalid sub domain")
        }
    }
    
    func validateScope(scope :[String]) throws{
        
        guard !scope.isEmpty else{
            throw OAuthError.IllegalParameter("invalid scope")
        }
    }
    
    func validateAccessType(accessType :String) throws{
        
        guard !accessType.isEmpty else{
            
            throw OAuthError.IllegalParameter("invalid accessType")
            
        }
    }
    
    
    //MARK: MAKE REQUESTS
    public func makeTokenRequest(tokenRequest : OAuthTokenRequest,handler : TokenInfoHandler?){
        
        let params = tokenRequest.getRequestParam()
        
        let URL = NSURL(string: Constants.OAuth.getTokenUrl(tokenRequest.authDomain))
        
        let mutableURLRequest = NSMutableURLRequest(URL:URL!)
        mutableURLRequest.HTTPMethod = Alamofire.Method.POST.rawValue
        mutableURLRequest.timeoutInterval = timeOutInterval
        
        let urlRequest =  ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
        
        makeRequest(urlRequest) { (success, httpRequest, httpResponse, responseJson, error) -> Void in
            
            self.handleTokenResponse(success, respJson: responseJson, error: error, handler: handler)
        }
    }
    
    internal func fetchAccessTokenInfo(authDomain : String,accessToken:String,handler : TokenInfoHandler?){
        
        let URL = NSURL(string: Constants.OAuth.getTokenUrl(authDomain))
            
        let mutableURLRequest = NSMutableURLRequest(URL:URL!)
        mutableURLRequest.HTTPMethod = Alamofire.Method.GET.rawValue
        mutableURLRequest.timeoutInterval = timeOutInterval
        
        let param = [OauthParamName.ACCESS_TOKEN:accessToken]
        
        let urlRequest =  ParameterEncoding.URL.encode(mutableURLRequest, parameters: param).0
        
        makeRequest(urlRequest) { (success, httpRequest, httpResponse, responseJson, error) -> Void in
            
            self.handleTokenResponse(success, respJson: responseJson, error: error, handler: handler)
        }
    }
    
    
    //MARK: UTILS
    public func makeRequest(urlRequest : URLRequestConvertible, handler : ApiResponseHandler?){
        
        let request = Alamofire.request(urlRequest)
        
        request.responseJSON { (response) -> Void in
            
            if handler != nil {
                
                let error = response.result.error
                
                let success :Bool = (response.result.isSuccess && response.response?.statusCode >= 200 && response.response?.statusCode <= 299)
                
                let jsonDict = response.result.value as? [String: AnyObject]
                
                handler!(success : success, httpRequest : response.request!, httpResponse : response.response!, responseJson :jsonDict , error : error)
            }
        }
    }
    
    public func handleTokenResponse(success : Bool, respJson :[String : AnyObject?]?,error : NSError?, handler : TokenInfoHandler?){
        
        if handler != nil{
            
            if success {
                
                handler!(error : nil,errorResponse: nil, accessToken : OAuthAccessToken(data: respJson!))
                
                return
            }
            
            var errorResp : OAuthTokenErrorResponse?
            
            if respJson != nil {
                
                errorResp = OAuthTokenErrorResponse(data: respJson!)
            }
            
            
            handler!(error: error, errorResponse: errorResp, accessToken: nil)
        }
    }
}

