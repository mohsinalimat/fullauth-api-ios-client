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
    
    static let AuthDomain = "set your sub domain"
    
    static let ClientId = "your client id"
    
    static let ClientSecret = "your client secret"
    
    static let Scope = [""]
    
    static let AccessToken = "set your access token"
    
}


class TestFullAuthClient: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestTokenInfo()

    }


    //MARK: REQUEST TOKEN INFO
    
    func requestTokenInfo(){
        
        let oauthObj = FullAuthOAuthService(authDomain: OAuthParamHelper.AuthDomain)
    
        do{

            try oauthObj.getTokenInfo(OAuthParamHelper.AccessToken, handler: { (error, responce) -> Void in
                
                print("Response -- \(responce)")
            })
            
        }catch let error {
        
            let err = error as? OAuthError
            
            print("Error -- \(err?.description)")
        }
    }

}

