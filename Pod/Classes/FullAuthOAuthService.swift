
import UIKit
import Alamofire
import Foundation

open class FullAuthOAuthService {
    
    let authDomain : String!
    
    var clientId : String?
    
    var clientSecret : String?
    

    //For AuthCode
    var queryString: String?
    
    open var timeOutInterval : TimeInterval = 60
    
    public typealias ApiResponseHandler = (_ success : Bool,_ httpRequest : URLRequest?,_ httpResponse :  HTTPURLResponse?,_ responseJson : [String : AnyObject?]?,_ error : NSError?) -> Void
    
    public typealias TokenInfoHandler = (_ error : NSError?,_ errorResponse : OAuthTokenErrorResponse?,_ accessToken : OAuthAccessToken?) -> Void
    
    public typealias revokeTokenHandler = (_ success: Bool,_ error : NSError?,_ errorResponse : OAuthTokenErrorResponse?) -> Void
    
    
    //Req init
    public init(authDomain : String){
        
        self.authDomain = authDomain
    }
    
    public convenience init (authDomain : String,clientId :String? = nil,clientSecret : String? = nil){
        
        self.init(authDomain: authDomain)
        
        if let clientId = clientId{
            self.clientId = clientId
        }
        
        if let clientSecret = clientSecret{
            self.clientSecret = clientSecret
        }
    }
}
