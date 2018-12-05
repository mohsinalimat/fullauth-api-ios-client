//
//  Enums.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit

public enum OauthAccessType : String, Codable {
    
    case online = "online"
    
    case offline = "offline"

    static func getType(accessType : String) -> OauthAccessType{
        
        switch accessType.uppercased(){
            
        case "ONLINE":
            return .online
            
        case "OFFLINE":
            return .offline
            
        default:
            return .offline
        }
    }
}

public enum OauthExpiryType : String {
    
    case short = "short"

    case long = "long"
}


public enum OauthGrantType : String {
    
    case refreshToken = "refresh_token"

    case password = "password"
    
    case googleToken = "google_token"
    
    case facebookToken = "facebook_token"
    
    case code = "authorization_code"
}


public enum AccessTokenType: String {
    
    case refreshToken = "refresh"
    
    case googleToken = "google"
    
    case facebookToken = "facebook"
    
    case defaultToken = "access token"
    
    static func getAccessToken(forType type: AccessTokenType) -> String{
        
        switch type {
            
        case .refreshToken:
            return "refresh token"
    
        case .googleToken:
            return "google access token"
            
        case .facebookToken:
            return "facebook access token"
            
        default:
            return "access token"
        }
    }
}
