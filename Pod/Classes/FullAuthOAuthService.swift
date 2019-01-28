
import UIKit
import Alamofire
import Foundation

open class FullAuthOAuthService {
    
    let authDomain : String
    
    var clientId : String?
    
    var clientSecret : String?
    
    var liveMode: Bool
    
    var isCustomURL: Bool = false

    //For AuthCode
    var queryString: String?
    
    open var timeOutInterval : TimeInterval = 60
    
    public typealias ApiResponseHandler = (_ success : Bool, _ httpRequest: URLRequest?, _ httpResponse:  HTTPURLResponse?, _ responseJson: [String : Any?]?, _ error : Error?) -> Void
    
    public typealias TokenInfoHandler = (_ error : Error?,_ errorResponse : OAuthTokenErrorResponse?,_ accessToken : OAuthAccessToken?) -> Void
    
    public typealias revokeTokenHandler = (_ success: Bool,_ error : Error?,_ errorResponse : OAuthTokenErrorResponse?) -> Void
    
    
    public init(liveMode: Bool = true, authDomain: String, clientId :String? = nil, clientSecret : String? = nil){
        
        self.authDomain = authDomain
        self.liveMode = liveMode
        
        if let clientId = clientId {
            self.clientId = clientId
        }
        
        if let clientSecret = clientSecret {
            self.clientSecret = clientSecret
        }
    }
    
    public convenience init(liveMode: Bool = true, isCustomURL: Bool, authDomain: String, clientId :String? = nil, clientSecret : String? = nil) {

        self.init(liveMode: liveMode, authDomain: authDomain, clientId: clientId, clientSecret: clientSecret)
        self.isCustomURL = isCustomURL
    }
    
    
    //MARK:FetchAuthUrl
    open func getAuthCodeUrl(scopes: [String], accessType : OauthAccessType? = .offline, approval_prompt: String? = "force", redirectUrl: String) throws -> String {
        
        try validateOauthDomain()
        
        try validateOauthClientId()
        
        try validateScope(scopes)
        
        return generateAuthCodeUrl(scopes: scopes, access_type: accessType, approval_prompt: approval_prompt, redirectUrl: redirectUrl)
    }
    
    private func generateAuthCodeUrl(scopes: [String], access_type: OauthAccessType?, approval_prompt: String?, redirectUrl: String) -> String {
        
        var baseUrl: String = Constants.OAuth.getAuthUrl(liveMode, self.authDomain, self.isCustomURL)
        
        let clientId = self.clientId ?? ""
        
        let scope = scopes.joined(separator: "%20")
        
        //let redirect_uri = "urn:ietf:wg:oauth:2.0:oob:auto"
        
        var urlParams: [String: Any] = [:]
        
        if let accessType = access_type {
            urlParams.updateValue(accessType, forKey: "access_type")
        }
        
        if let approvalPrompt = approval_prompt {
            urlParams.updateValue(approvalPrompt, forKey: "approval_prompt")
        }
        
        let path = Constants.OAuth.FULLAUTH_OAUTH2_AUTH
        
        var url = "\(baseUrl)\(path)?response_type=code&client_id=\(clientId)&scope=\(scope)&redirect_uri=\(redirectUrl)"
        
        for (key,value) in urlParams {
            url.append("&\(key)=\(value)")
        }
        
        return url
    }
}
