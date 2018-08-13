//
//  ConstantsTest.swift
//  FullAuthIOSClient_Tests
//
//  Created by Monica on 13/08/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import FullAuthIOSClient

class ConstantsTest: XCTestCase {

    func testPerformanceExample() {
        self.measure {
            
            test_getAuthUrl_withLiveMode()
            test_getAuthUrl_withStagingMode()
            test_getTokenUrl_withLiveMode()
            test_getTokenUrl_withStagingMode()
            test_getRevokeTokenUrl_liveMode()
            test_getRevokeTokenUrl_stagingMode()
        }
    }
    
    func test_getAuthUrl_withLiveMode() {
        
        let liveAuthUrl = Constants.OAuth.getAuthUrl(true, "fullCreative")
        let expectedAuthUrl = "https://fullCreative.fullauth.com"
        
        XCTAssertEqual(liveAuthUrl, expectedAuthUrl)
        XCTAssertNotEqual(liveAuthUrl, "https://fullCreative.staging.anywhereauth.com")
    }
    
    func test_getAuthUrl_withStagingMode() {
        
        let stagingAuthUrl = Constants.OAuth.getAuthUrl(false, "fullCreative")
        let expectedAuthUrl = "https://fullCreative.staging.anywhereauth.com"
        
        XCTAssertEqual(stagingAuthUrl, expectedAuthUrl)
        XCTAssertNotEqual(stagingAuthUrl, "https://fullCreative.fullauth.com")
    }
    
    func test_getTokenUrl_withLiveMode() {
     
        let liveTokenUrl = Constants.OAuth.getTokenUrl(true, "fullCreative")
        let expectedTokenUrl = "https://fullCreative.fullauth.com/o/oauth2/v1/token"
        
        XCTAssertEqual(liveTokenUrl, expectedTokenUrl)
        XCTAssertNotEqual(liveTokenUrl, "https://fullCreative.staging.anywhereauth.com/o/oauth2/v1/token")
        XCTAssertNotEqual(liveTokenUrl, "https://fullCreative.fullauth.com")
    }
    
    func test_getTokenUrl_withStagingMode() {
        
        let stagingTokenUrl = Constants.OAuth.getTokenUrl(false, "fullCreative")
        let expectedTokenUrl = "https://fullCreative.staging.anywhereauth.com/o/oauth2/v1/token"
        
        XCTAssertEqual(stagingTokenUrl, expectedTokenUrl)
        XCTAssertNotEqual(stagingTokenUrl, "https://fullCreative.fullauth.com/o/oauth2/v1/token")
        XCTAssertNotEqual(stagingTokenUrl, "https://fullCreative.staging.anywhereauth.com")
        
    }
    
    func test_getRevokeTokenUrl_liveMode() {
        
        let liveRevokeTokenUrl = Constants.OAuth.getRevokeTokenUrl(true, authDomain: "fullCreative")
        let expectedRevokeTokenUrl = "https://fullCreative.fullauth.com/o/oauth2/revoke"
        
        XCTAssertEqual(liveRevokeTokenUrl, expectedRevokeTokenUrl)
        XCTAssertNotEqual(liveRevokeTokenUrl, "https://fullCreative.staging.anywhereauth.com/o/oauth2/revoke")
        XCTAssertNotEqual(liveRevokeTokenUrl, "https://fullCreative.fullauth.com")
    }
    
    func test_getRevokeTokenUrl_stagingMode() {
        
        let liveRevokeTokenUrl = Constants.OAuth.getRevokeTokenUrl(false, authDomain: "fullCreative")
        let expectedRevokeTokenUrl = "https://fullCreative.staging.anywhereauth.com/o/oauth2/revoke"
        
        XCTAssertEqual(liveRevokeTokenUrl, expectedRevokeTokenUrl)
        XCTAssertNotEqual(liveRevokeTokenUrl, "https://fullCreative.fullauth.com/o/oauth2/revoke")
        XCTAssertNotEqual(liveRevokeTokenUrl, "https://fullCreative.staging.anywhereauth.com")
    }
}
