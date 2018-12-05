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
    
     static let clientId = "client_id"
    
     static let clientSecret = "client_secret"
    
     static let accessToken = "access_token"
    
     static let redirectUrl = "redirect_uri"
    
     static let responseType = "response_type"
    
     static let accessType = "access_type"
    
     static let scope = "scope"
    
     static let approvalPrompt = "approval_prompt"
    
     static let grantType = "grant_type"
    
     static let code = "code"
    
     static let refreshToken = "refresh_token"
    
     static let googleToken = "google_token"
    
     static let facebookToken = "facebook_token"
    
     static let expiryType = "expiry_type"

     static let username = "username"
    
     static let password = "password"
}
