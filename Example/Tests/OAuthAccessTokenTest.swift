//
//  OAuthAccessTokenTest.swift
//  FullAuthIOSClient_Tests
//
//  Created by Sathish on 16/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import FullAuthIOSClient


class OAuthAccessTokenTest: XCTestCase {
    
    
    func test1ValidateOAuthAccessToken() {
        
        let sampleData: [String: Any?] = ["expires": 1542634836220,
                                          "user_id":  "03e30e43-1762-4e71-a273-68f6484b8955",
                                          "access_token": "dummyAccessToken",
                                          "refresh_token": "dummyRefreshToken",
                                          "token_type": "BEARER",
                                          "access_type": "OFFLINE",
                                          "scopes": [ "awapis.identity", "awapis.users.read"],
                                          "expires_in": 348517,
                                          "issued_to": "29354-3483783c6d5215a72d969f7d3a608684"]

        
        let oauthAccessToken = OAuthAccessToken(data: sampleData)
        XCTAssertEqual(oauthAccessToken.accessToken, "dummyAccessToken")
        XCTAssertEqual(oauthAccessToken.expiresIn, 348517)
        XCTAssertEqual(oauthAccessToken.tokenType, "BEARER")
        
        XCTAssertNotNil(oauthAccessToken.expires)
        XCTAssertNotNil(oauthAccessToken.userId)
        XCTAssertNotNil(oauthAccessToken.refreshToken)
        XCTAssertNotNil(oauthAccessToken.accessType)
        XCTAssertNotNil(oauthAccessToken.issuedTo)
    }
    
    func test2InValidateOAuthAccessToken() {
        
        let sampleData: [String: Any?] = ["access_token": "dummyAccessToken",
                                    "expires_in": 348517,
                                    "token_type": "OFFLINE"]
        
        let oauthAccessToken = OAuthAccessToken(data: sampleData)
        XCTAssertEqual(oauthAccessToken.accessToken, "dummyAccessToken")
        XCTAssertEqual(oauthAccessToken.expiresIn, 348517)
        XCTAssertEqual(oauthAccessToken.tokenType, "OFFLINE")
        
        XCTAssertNil(oauthAccessToken.expires)
        XCTAssertNil(oauthAccessToken.userId)
        XCTAssertNil(oauthAccessToken.refreshToken)
        XCTAssertNil(oauthAccessToken.accessType)
        XCTAssertNil(oauthAccessToken.issuedTo)
    }
}
