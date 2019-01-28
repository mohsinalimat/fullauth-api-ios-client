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
        
        open static let STAGING_FULLAUTH_BASE_URL = "https://%@.staging.anywhereauth.com"

        open static let FULLAUTH_OAUTH2_AUTH = "/o/oauth2/auth"
        
        open static let FULLAUTH_OAUTH2_TOKEN = "/o/oauth2/v1/token"
        
        open static let FULLAUTH_REVOKE_TOKEN = "/o/oauth2/revoke"
        
        // Custom URL
        open static let FULLAUTH_CUSTOM_BASE_URL = "https://%@"
        
        open static func getAuthUrl(_ liveMode: Bool, _ authDomain : String,  _ isCustomURL: Bool = false) -> String{
            
            guard isCustomURL else {
                let BASE_URL = liveMode ? FULLAUTH_BASE_URL : STAGING_FULLAUTH_BASE_URL
                return String(format: BASE_URL, authDomain)
            }
            
            let BASE_URL = FULLAUTH_CUSTOM_BASE_URL
            return String(format: BASE_URL, authDomain)
        }
        
        open static func getTokenUrl(_ liveMode: Bool, _ authDomain : String) -> String{

            return getAuthUrl(liveMode, authDomain) + FULLAUTH_OAUTH2_TOKEN
        }

        open static func getRevokeTokenUrl(_ liveMode: Bool, authDomain: String) -> String{
            
            return getAuthUrl(liveMode, authDomain) + FULLAUTH_REVOKE_TOKEN
        }
    }
}
