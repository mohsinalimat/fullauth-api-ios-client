//
//  OauthParamName.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit
import Foundation

struct OauthParamName: Codable {
    
     static let CLIENT_ID = "client_id"
    
     static let CLIENT_SECRET = "client_secret"
    
     static let ACCESS_TOKEN = "access_token"
    
     static let REDIRECT_URI = "redirect_uri"
    
     static let RESPONSE_TYPE = "response_type"
    
     static let ACCESS_TYPE = "access_type"
    
     static let SCOPE = "scope"
    
     static let APPROVAL_PROMPT = "approval_prompt"
    
     static let GRANT_TYPE = "grant_type"
    
     static let CODE = "code"
    
     static let REFRESH_TOKEN = "refresh_token"
    
     static let GOOGLE_TOKEN = "google_token"
    
     static let FACEBOOK_TOKEN = "facebook_token"
    
     static let EXPIRY_TYPE = "expiry_type"

     static let USERNAME = "username"
    
     static let PASSWORD = "password"
    
     static let JWT = "jwt"
}
