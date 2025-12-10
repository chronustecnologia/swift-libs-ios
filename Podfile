platform :ios, '15.0'

use_frameworks!
inhibit_all_warnings!

project 'SwiftLibs.xcodeproj'
workspace 'SwiftLibs.xcworkspace'

def shared_pods
  pod 'SLCommonExtensions', :path => './Libraries/SLCommonExtensions'
  pod 'SLNotificationServiceInterface', :path => './Libraries/SLNotificationServiceInterface'
  pod 'SLNotificationService', :path => './Libraries/SLNotificationService'
  pod 'SLNotificationName', :path => './Libraries/SLNotificationName'
  pod 'SLLocationManager', :path => './Libraries/SLLocationManager'
  pod 'SLCommonError', :path => './Libraries/SLCommonError'
  pod 'SLStorageInterface', :path => './Libraries/SLStorageInterface'
  pod 'SLStorage', :path => './Libraries/SLStorage'
  pod 'SLCommonImages', :path => './Libraries/SLCommonImages'
  pod 'SLNetworkManager', :path => './Libraries/SLNetworkManager'
  pod 'DSKit', :path => './Libraries/DSKit'
end

target 'SwiftLibs' do
  #use_frameworks!
  project 'SwiftLibs'
  source 'https://git-codecommit.us-east-1.amazonaws.com/v1/repos/release-mobile-ios-specs'
  source 'https://github.com/CocoaPods/Specs.git'

  shared_pods
  
  pod 'SnapKit'
end
