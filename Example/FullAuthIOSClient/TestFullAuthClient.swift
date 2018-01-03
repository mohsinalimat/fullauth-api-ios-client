//
//
//  FullAuthIOSClient
//
//  Created by karthik-dev on 12/23/2015.
//  Copyright (c) 2015 karthik-dev. All rights reserved.
//


import UIKit
import Foundation
import FullAuthIOSClient
import SafariServices

struct OAuthParamHelper {
    
    static let AuthDomain = ""
    
    static let ClientId = ""
    
    static let ClientSecret = ""
    
    static let Scope = [""]
    
    static let AccessToken = ""
}


class TestFullAuthClient: UIViewController, SFSafariViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
  
    @IBAction func btnAction(_ sender: Any) {
    
    }
    
    //MARK: REQUEST TOKEN INFO
    func requestTokenInfo(){
        
        let oauthObj = FullAuthOAuthService(authDomain: OAuthParamHelper.AuthDomain)
    
        do{
            
            try oauthObj.getTokenInfo("Pass your access token here", handler: { (error, errorResponse, accessToken) -> Void in
                
                if error != nil{
                    
                    print("Error ---\(error!)")
                }
                
                if errorResponse != nil {
                    
                    print("Error Response --\(errorResponse!)")
                    
                    let errResp  = errorResponse
                    
                    print("error_dese --\(String(describing: errResp?.errorDesc))")
                }
                
                if accessToken != nil {
                    
                    print("Response -- \(accessToken!)")
                    
                    print("AccessToken -- \(String(describing: accessToken?.accessToken))")
                }
            })
            
        }catch let error {
            
            let err = error as? OAuthError
            
            print("Error -- \(String(describing: err?.description))")
        }
    }
    
    
    func revokeAccessToken() {
        
        let oauth = FullAuthOAuthService(authDomain: OAuthParamHelper.AuthDomain)
        
        try! oauth.revokeAccessToken(accessToken: "pass your access token here", handler: { (success, error, errorResp) in
            
        })
    }
    
    
    //To present a view and get the code with this url
    func getAuthCodeUrl() {
        
        let authCodeObj = AuthCodeRequest(authDomain: "", clientId: "", scopes: [], accessType: .offline)
        
        guard _ = authCodeObj.getAuthCodeUrl() else {
            return
        }
        
        // use this url to present
    }
}
