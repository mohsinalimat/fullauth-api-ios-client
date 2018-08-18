# FullAuthIOSClient
[![Build Status](https://travis-ci.com/FullCreative/fullauth-api-ios-client.svg?branch=master)](https://travis-ci.com/FullCreative/fullauth-api-ios-client)
[![CI Status](http://img.shields.io/travis/karthik-dev/FullAuthIOSClient.svg?style=flat)](https://travis-ci.org/karthik-dev/FullAuthIOSClient)
[![Version](https://img.shields.io/cocoapods/v/FullAuthIOSClient.svg?style=flat)](http://cocoapods.org/pods/FullAuthIOSClient)
[![License](https://img.shields.io/cocoapods/l/FullAuthIOSClient.svg?style=flat)](http://cocoapods.org/pods/FullAuthIOSClient)
[![Platform](https://img.shields.io/cocoapods/p/FullAuthIOSClient.svg?style=flat)](http://cocoapods.org/pods/FullAuthIOSClient)

## Supported Operations

- [Requesting Access Token](#requesting-access-token)

  - [Using Resource Owner Credentials](#using-resource-owner-credentials)
  - [Using Google Access Token](#using-google-access-token)
  - [Using Facebook Access Token](#using-facebook-access-token)

- [Fetch access token information](#fetch-access-token-information)

- [Refresh Access Token](#refresh-access-token)

- [Revoke Access Token](#revoke-access-token)

## Requirements

- iOS 9.0+ 
- Xcode 8.3+
- Swift 4.1+

## Latest Version

1.0.1 is the current latest version
For change logs refer [Releases](https://github.com/FullCreative/fullauth-api-ios-client/releases)

## Installation

FullAuthIOSClient is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FullAuthIOSClient"
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requesting Access Token

There are few supported flows in the fullAuth specification to request access token as follows

Create an `authService` by providing the necessary inputs.
```swift
let authService =  FullAuthOAuthService(authDomain: "your auth domain":, clientId: "client-id", clientSecret: "client-secret")
```

 ### Using Resource Owner Credentials
 A Resource Owner’s username and password are submitted as part of the request, and a token is issued upon successful authentication.
 
 ```swift 
 do {
     try authService.requestAccessTokenForResourceCredentials("user-email-id", password: "password", scope: ["scope1", "scope2"], accessType: .OFFLINE, handler: { (error, errorResponse, accessToken) -> Void in
     // process full auth response
          })
     } catch let err {
              // handle error 
     }
```
 
 ### Using Google Access Token
 Request AccessToken by passing valid google access token.
 
 ```swift
  do {
      try authService.requestAccessTokenForGoogleToken(googleAccessToken: "googleToken", scope: ["scope1", "scope2"], accessType: .OFFLINE, handler: { (error, errorResponse, accessToken) in
                    // process the response
                })
     } catch let err {
              // handle the error 
     }
 ```
 ### Using Facebook Access Token
 Request AccessToken by passing valid facebook access token.
 
  ```swift
  do {
      try authService.requestAccessTokenForGoogleToken(faceBookAccessToken: "facebookToken", scope: ["scope1", "scope2"], accessType: .OFFLINE, handler: { (error, errorResponse, accessToken) in
                    // process the response
                })
     } catch let err {
              // handle the error 
     }
 ```

## Fetch access token information
Access token information can be obtained by the following method.

```swift 
do {
    try authService.getTokenInfo("pass the accessToken") { (err, errResponse, token) in
            // token information is received here
        }
    } catch {
            // handle the error
    }
 ```
 
## Refresh Access Token
You can submit a refresh token and receive a new access token if the access token had expired.

```swift
 do {
     try authService.refreshAccessToken("your refreshToken", expiryType: OauthExpiryType.LONG) { (error, errorResponse, accessToken) -> Void in
            // Save the access token
    } catch let error {
            // print("error: \(error)")
    }
```

## Revoke Access Token
Revoke a valid AccessToken.

```swift 
 do {
     try authService.revokeAccessToken(accessToken: "your access token") { (success, err, errResp) in
               // success for revoking the access token
     } catch {
          // print error
     }
```

 
## Author

karthik-dev, karthik.samy@a-cti.com 
Monica Raja, monica.raja@anywhere.co

## License

FullAuthIOSClient is available under the MIT license. See the LICENSE file for more info.
