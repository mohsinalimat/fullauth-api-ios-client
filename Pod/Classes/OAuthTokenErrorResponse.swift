//
//  OauthTokenErrorResponse.swift
//  FullAuth-Api-Ios-Client
//
//  Created by Karthik on 19/12/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit

public struct OAuthTokenErrorResponse {
    
    public var error : String?
    
    public var errorDesc :String?
    
    public var errorUri : String?
    
    public init(){ }

    public init(error : String, errorDesc : String){

        self.error = error
        self.errorDesc = errorDesc
    }
    
    public init(data : [String : Any?]){
        
        if let err = data["error"] as? String{
            self.error = err
        }
        
        if let errorDesc = data["error_description"] as? String{
            self.errorDesc = errorDesc
        }
        
        if let errorUri = data["error_uri"] as? String{
            self.errorUri = errorUri
        }
    }
    
    public var description : String {
        return "error : \(self.error), error_description : \(self.errorDesc)"
    }
}
