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
    static func getType(accessType accessType : String) -> OauthAccessType{
        
        switch accessType.uppercaseString{
            
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

