
Pod::Spec.new do |s|
  s.name             = "FullAuthIOSClient"
  s.version          = "0.9.6"
  s.swift_version    = '4.0'
  s.summary          = "A IOS client library to communicate with the FullAuth Apis for authentication, token exchange, retrieve access token, etc"

  s.homepage         = "https://github.com/FullCreative/fullauth-api-ios-client.git"

  s.license          = 'MIT'
  s.author           = { "Karthik samy" => "karthik.samy@a-cti.com" }
  s.source           = { :git => "https://github.com/FullCreative/fullauth-api-ios-client.git", :tag => s.version.to_s }

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'Alamofire', '~> 4.5'
end
