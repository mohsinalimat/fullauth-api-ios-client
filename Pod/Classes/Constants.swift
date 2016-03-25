//
//  Constants.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit


public class Constants {
    /**
     * The type Oauth.
     */
    public class OAuth {
        

        public static let FULLAUTH_BASE_URL = "https://%@.fullauth.com"
        /**
         * The constant FULLAUTH_OAUTH2_AUTH.
         */
        public static let FULLAUTH_OAUTH2_AUTH = "/o/oauth2/auth"
        
        /**
         * The constant FULLAUTH_OAUTH2_TOKEN.
         */
        public static let FULLAUTH_OAUTH2_TOKEN = "/o/oauth2/v1/token"
        
        public static let FULLAUTH_REVOKE_TOKEN = "/o/oauth2/revoke"
        
        /**
         * Get auth url.
         *
         * @param authDomain the auth domain
         * @return the string
         */
        public static func getAuthUrl(authDomain : String) -> String{
            
            return String(format: FULLAUTH_BASE_URL,authDomain)
        }
        
        /**
         * Get token url.
         *
         * @param authDomain the auth domain
         * @return the string
         */
        public static func getTokenUrl(authDomain : String) -> String{
            
            return getAuthUrl(authDomain) + FULLAUTH_OAUTH2_TOKEN

        }


        public static func getRevokeTokenUrl(authDomain authDomain: String) -> String{
            
            return getAuthUrl(authDomain) + FULLAUTH_REVOKE_TOKEN
        }
    }
}