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
    
    static let AuthDomain = "YoCoBoard"
    
    static let ClientId = "29354-e671abd9f0d9d1d18c3860d259db1222"
    
    static let ClientSecret = "pc_S9_GWWYzkxjdjVBwh4TQa2oROYEWm3hwLyiNu"
    
    static let Scope = ["awapis.fullaccess"]
    
    static let AccessToken = "yourAccessToken"    
}


class TestFullAuthClient: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTokenInfo()
    }
  

    @IBAction func btnAction(_ sender: Any) {
    
        let temp = FullAuthVC.webViewController!
        self.present(temp, animated: true, completion: nil)
        
    }
    
    
    //MARK: REQUEST TOKEN INFO
    func requestTokenInfo(){
        
        let oauthObj = FullAuthOAuthService(authDomain: OAuthParamHelper.AuthDomain)
    
        do{
            
            try oauthObj.getTokenInfo("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdGFnaW5nLWZ1bGxjcmVhdGl2ZS5mdWxsYXV0aC5jb20iLCJpYXQiOjE1MDQyNTg4MjQsInVzZXJfaWQiOiI0OWQwMzk4OC0zYjZjLTRlNDktOTBjNS03ZjUyNDc4OTdjMTEiLCJleHAiOjE1MDQyNjYwMjQsImp0aSI6ImQ5OTMwLkJIc2hHTVA3YVAifQ.as-CGXPxefXHigBmrMTRcEaHbYFyBrO6ZY8jHzytVCc", handler: { (error, errorResponse, accessToken) -> Void in
                
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
    
    func revokeAccessToken() {
        
        let oauth = FullAuthOAuthService(authDomain: OAuthParamHelper.AuthDomain)
        
        try! oauth.revokeAccessToken(accessToken: "pass your access token here", handler: { (success, error, errorResp) in
            
        })
    }
    
    
    func getAuthCodeUrl() -> String {
        
        let oauth = FullAuthOAuthService(authDomain: OAuthParamHelper.AuthDomain)
        
        return ""
    }
}


extension TestFullAuthClient: AuthCodeDelegate {
    
    func didStartLoad() {
        print("Started loading")
    }
    
    func didFinishLoad(withCode code: String, receiver: UIViewController) {
        print("finished loading")
    }
    
    func didFailLoad(withError error: Error?, receiver: UIViewController) {
        print("failed to load")
    }
}


