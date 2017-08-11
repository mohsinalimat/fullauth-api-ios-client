
import UIKit
import Alamofire
import Foundation

open class FullAuthOAuthService {
    
    let authDomain : String
    
    var clientId : String?
    
    var clientSecret : String?
    
    open var timeOutInterval : TimeInterval = 60
    
    public typealias ApiResponseHandler = (_ success : Bool, _ httpRequest: URLRequest?, _ httpResponse:  HTTPURLResponse?, _ responseJson: [String : Any?]?, _ error : Error?) -> Void
    
    public typealias TokenInfoHandler = (_ error : Error?,_ errorResponse : OAuthTokenErrorResponse?,_ accessToken : OAuthAccessToken?) -> Void
    
    public typealias revokeTokenHandler = (_ success: Bool,_ error : Error?,_ errorResponse : OAuthTokenErrorResponse?) -> Void
    
    
    public init(authDomain: String, clientId :String? = nil, clientSecret : String? = nil){
        
        self.authDomain = authDomain
        
        if let clientId = clientId{
            self.clientId = clientId
        }
        
        if let clientSecret = clientSecret{
            self.clientSecret = clientSecret
        }
    }
    
    
    private func generateAuthCodeUrl(scopes: [String], access_type: OauthAccessType?, approval_prompt: String?, response_type: String) -> String {
        
        var baseUrl: String = Constants.OAuth.getAuthUrl(self.authDomain)
        
        let clientId = self.clientId ?? ""
        
        let scope = scopes.joined(separator: " ")
        
        let redirect_uri = "urn:ietf:wg:oauth:2.0:oob:auto"
        
        var urlParams: [String: Any] = [:]
        
        if let accessType = access_type {
            urlParams.updateValue(accessType, forKey: "access_type")
        }
        
        if let approvalPrompt = approval_prompt {
            urlParams.updateValue(approvalPrompt, forKey: "approval_prompt")
        }
        
        let path = Constants.OAuth.FULLAUTH_OAUTH2_AUTH
        
        var url = "\(baseUrl)\(path)?response_type=\(response_type)&client_id=\(clientId)&scope=\(scope)&redirect_uri=\(redirect_uri)"
        
        for (key,value) in urlParams {
            url.append("&\(key)=\(value)")
        }
        
        return url
    }
    
    
    //MARK: REFRESH ACCESS TOKEN
    open func refreshAccessToken(_ refreshToken: String, expiryType : OauthExpiryType? = nil, handler : TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateOauthClient()
        
        try validateAccessToken(accesstoken: refreshToken, tokenType: .refreshToken)
        
        let request = RefreshTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, refreshToken: refreshToken, expiryType: expiryType)
        
        try makeTokenRequest(request, handler: handler)
    }
    
    //MARK:REQUEST ACCESS FOR USERNAME AND PASSWORD
    
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
    
    
    //MARK:REQUEST ACCESS FOR GOOGLE TOKEN
    open func requestAccessTokenForGoogleToken(googleAccessToken : String, scope : [String], accessType : OauthAccessType? = nil, handler : TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateOauthClient()
        
        try validateAccessToken(accesstoken: googleAccessToken, tokenType: .googleToken)
        
        try validateScope(scope)
        
        let request =  GoogleTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, scope: scope, googleToken: googleAccessToken, accessType: accessType)
        
        try self.makeTokenRequest(request,handler: handler)
    }
    
    //MARK:REQUEST ACCESS FOR FACEBOOK TOKEN
    open func requestAccessTokenForFacebookToken(facebookAccessToken: String, scope: [String], accessType: OauthAccessType? = nil, handler: TokenInfoHandler?) throws{
        
        try validateOauthDomain()
        
        try validateAccessToken(accesstoken: facebookAccessToken, tokenType: .facebookToken)
        
        try validateOauthClient()
        
        try validateScope(scope)
        
        let request = FacebookTokenRequest(authDomain: self.authDomain, clientId: self.clientId!, clientSecret: self.clientSecret!, scope: scope, facebookToken: facebookAccessToken, accessType: accessType)
        
        try makeTokenRequest(request, handler: handler)
    }
    
    
    //MARK:FetchAuthUrl
    open func fetchAuthCodeUrl(scopes: [String], accessType : OauthAccessType? = .offline, approval_prompt: String?, responseType: String) throws -> String {
        
        try validateOauthDomain()
        
        try validateOauthClient()
        
        try validateScope(scopes)
        
        return generateAuthCodeUrl(scopes: scopes, access_type: accessType, approval_prompt: approval_prompt, response_type: responseType)
    }
}


//MARK: VALIDATION UTILS
extension FullAuthOAuthService {
    
    func validateAccessToken(accesstoken: String, tokenType: AccessTokenType) throws {
        
        guard !accesstoken.isEmpty else{
            throw OAuthError.illegalParameter("invalid \(AccessTokenType.getAccessToken(forType: tokenType))")
        }
    }
    
    func validateOauthClient() throws{
        
        guard let clientid = clientId, !clientid.isEmpty else {
            throw OAuthError.errorCode(.invalidClient)
        }
        
        guard let clientsecret = clientSecret, !clientsecret.isEmpty else {
            throw OAuthError.errorCode(.invalidClientSecret)
        }
    }
    
    func validateOauthDomain() throws{
        
        guard !self.authDomain.isEmpty else{
            throw OAuthError.errorCode(.invalidDomain)
        }
    }
    
    func validateScope(_ scope :[String]) throws{
        
        guard !scope.isEmpty else{
            throw OAuthError.errorCode(.invalidScope)
        }
    }
    
    func validateAccessType(_ accessType :String) throws{
        
        guard !accessType.isEmpty else{
            throw OAuthError.errorCode(.invalidAccessType)
        }
    }
}
