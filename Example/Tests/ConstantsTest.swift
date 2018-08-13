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
        XCTAssertEqual(liveAuthUrl, "https://fullCreative.fullauth.com")
    }
        
    func test_getAuthUrl_withStagingMode() {
        
        let stagingAuthUrl = Constants.OAuth.getAuthUrl(false, "fullCreative")
        XCTAssertEqual(stagingAuthUrl, "https://fullCreative.staging.anywhereauth.com")
    }
    
    func test_getTokenUrl_withLiveMode() {
     
        let liveTokenUrl = Constants.OAuth.getTokenUrl(true, "fullCreative")
        XCTAssertEqual(liveTokenUrl, "https://fullCreative.fullauth.com/o/oauth2/v1/token")
    }
    
    func test_getTokenUrl_withStagingMode() {
        
        let stagingTokenUrl = Constants.OAuth.getTokenUrl(false, "fullCreative")
        XCTAssertEqual(stagingTokenUrl, "https://fullCreative.staging.anywhereauth.com/o/oauth2/v1/token")
    }
    
    func test_getRevokeTokenUrl_liveMode() {
        
        let liveRevokeTokenUrl = Constants.OAuth.getRevokeTokenUrl(true, authDomain: "fullCreative")
        XCTAssertEqual(liveRevokeTokenUrl, "https://fullCreative.fullauth.com/o/oauth2/revoke")
    }
    
    func test_getRevokeTokenUrl_stagingMode() {
        
        let liveRevokeTokenUrl = Constants.OAuth.getRevokeTokenUrl(false, authDomain: "fullCreative")
        XCTAssertEqual(liveRevokeTokenUrl, "https://fullCreative.staging.anywhereauth.com/o/oauth2/revoke")
    }
}
