//
//  Enums.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit

/**
 * The enum Oauth access type.
 */
public enum OauthAccessType : String {
    
    /**
     * The ONLINE.
     */
    case ONLINE = "online"
    
    /**
     * The OFFLINE.
     */
    case OFFLINE = "offline"

    /**
     * Gets type.
     *
     * @param accessType the access type
     * @return the type
     */
    static func getType(accessType : String) -> OauthAccessType{
        
        switch accessType.uppercased(){
            
        case "ONLINE": return .ONLINE
        case "OFFLINE" : return .OFFLINE
        default :return .OFFLINE
            
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
