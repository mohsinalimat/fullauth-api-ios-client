//
//  Enums.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit

public enum OauthAccessType : String {
    
    case ONLINE = "online"
    
    case OFFLINE = "offline"

    static func getType(accessType : String) -> OauthAccessType{
        
        switch accessType.uppercased(){
            
        case "ONLINE":
            return .ONLINE
        case "OFFLINE" :
            return .OFFLINE
        default:
            return .OFFLINE
        }
    }
}

public enum OauthExpiryType : String {
    
    case SHORT = "short"

    case LONG = "long"
}


public enum OauthGrantType : String {
    
    case REFRESH_TOKEN = "refresh_token"
    
    case PASSWORD = "password"
    
    case GOOGLE_TOKEN = "google_token"
    
    case FACEBOOK_TOKEN = "facebook_token"
    
    case JWT_BEARER = "urn:ietf:params:oauth:grant-type:jwt-bearer"
}

public enum AccessTokenType: String {
    
    case REFRESH = "refresh"
    
    case GOOGLE = "google"
    
    case FACEBOOK = "facebook"
    
    case DEFAULT = "access token"
    
    
    static func getAccessTokenString(_ type: AccessTokenType) -> String{
    
        var tokenStr : String
        
        switch type {
            
        case .REFRESH:
            tokenStr = "refresh token"
            
        case .GOOGLE:
            tokenStr = "google access token"
            
        case .FACEBOOK:
            tokenStr = "facebook access token"
            
        default:
            tokenStr = "access token"
        }
        
        return tokenStr
    }
}
