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

struct OAuthParamHelper {
    
    static let AuthDomain = "subdomain"
    
    static let ClientId = "yourClientId"
    
    static let ClientSecret = "yourClientSecret"
    
    static let Scope = ["yourScopes"]
    
    static let AccessToken = "yourAccessToken"    
}


class TestFullAuthClient: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  

    @IBAction func btnAction(_ sender: Any) {
        
        guard let vc = FullAuthVC.webViewController else{
            return
        }
        
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    //MARK: REQUEST TOKEN INFO
    func requestTokenInfo(){
        
        let oauthObj = FullAuthOAuthService(authDomain: OAuthParamHelper.AuthDomain)
    
        do{
            
            try oauthObj.getTokenInfo("", handler: { (error, errorResponse, accessToken) -> Void in
                
                if error != nil{
                    
                    print("Error ---\(error!)")
                }
                
                if errorResponse != nil{
                    
                    print("Error Response --\(errorResponse!)")
                    
                    let errResp  = errorResponse
                    
                    print("error_dese --\(String(describing: errResp?.errorDesc))")
                }
                
                if accessToken != nil{
                    
                    print("Response -- \(accessToken!)")
                    
                    print("AccessToken -- \(String(describing: accessToken?.accessToken))")
                }
                
            })
            
        }catch let error {
            
            let err = error as? OAuthError
            
            print("Error -- \(String(describing: err?.description))")
        }
    }
}


extension TestFullAuthClient: AuthCodeDelegate {
    
    
    func revokeAccessToken() {
        
        let oauth = FullAuthOAuthService(authDomain: OAuthParamHelper.AuthDomain)
    
        try! oauth.revokeAccessToken(accessToken: "pass your access token here", handler: { (success, error, errorResp) in
    
        })
    }
    
    
    func getAuthCodeUrl() -> String {
        
        let oauth = FullAuthOAuthService(authDomain: OAuthParamHelper.AuthDomain)
    
        return try! oauth.getAuthCodeUrl(scopes: [])
    }
    
}


