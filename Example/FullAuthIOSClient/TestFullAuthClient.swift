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
        
        self.requestTokenInfo()

        self.userNameAndPasswordFetch()
    }


    //MARK: REQUEST TOKEN INFO
    
    func requestTokenInfo(){
        
        let oauthObj = FullAuthOAuthService(authDomain: OAuthParamHelper.AuthDomain)
    
        do{

            try oauthObj.getTokenInfo(OAuthParamHelper.AccessToken, handler: { (error, responce) -> Void in
                
                if error != nil{
                    
                    print("Error ---\(error)")
                }
                
                if responce != nil{
                    
                    print("Response -- \(responce)")
                }
                
            })
            
        }catch let error {
        
            let err = error as? OAuthError
            
            print("Error -- \(err?.description)")
        }
    }
    
    
    //MARK: RESOURCD OWNER CREDENTIALS 
    
    func userNameAndPasswordFetch(){
        
        let obj = FullAuthOAuthService(authDomain: OAuthParamHelper.AuthDomain, clientId: OAuthParamHelper.ClientId, clientSecret: OAuthParamHelper.ClientSecret)
        
        do{
            try obj.requestAccessTokenForResourceCredentials("karthik.samy@a-cti.com", password: "password", scope: OAuthParamHelper.Scope, handler: { (error, responce) -> Void in
                
                
                if error != nil {
                    
                    let err : OAuthError = error!
                    
                    print("Error --\(err.description)")
                    
                }
                
                if responce != nil {
                    
                    print("\n Response --\(responce!) \n")
                    
                    let temp : OAuthAccessToken = responce!
                    
                    print("\n Access Token --\(temp.accessToken) \n")
                }
                
            })
            
        }catch let err {
            
            let error = err as? OAuthError
            
            print("catched err --\(error?.description)")
            
        }
    }

}

