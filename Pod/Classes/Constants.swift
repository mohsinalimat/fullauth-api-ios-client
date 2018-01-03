//
//  Constants.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit

open class Constants {
    
    open class OAuth {
        
        open static let FULLAUTH_BASE_URL = "https://%@.fullauth.com"

        open static let FULLAUTH_OAUTH2_AUTH = "/o/oauth2/auth"
        
        open static let FULLAUTH_OAUTH2_TOKEN = "/o/oauth2/v1/token"
        
        open static let FULLAUTH_REVOKE_TOKEN = "/o/oauth2/revoke"
        
        open static func getAuthUrl(_ authDomain : String) -> String{
            
            return String(format: FULLAUTH_BASE_URL,authDomain)
        }
        
        open static func getTokenUrl(_ authDomain : String) -> String{

            return getAuthUrl(authDomain) + FULLAUTH_OAUTH2_TOKEN
        }

        open static func getRevokeTokenUrl(authDomain: String) -> String{
            
            return getAuthUrl(authDomain) + FULLAUTH_REVOKE_TOKEN
        }
    }
}
