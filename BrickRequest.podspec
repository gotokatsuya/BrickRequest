#
# Be sure to run `pod lib lint BrickRequest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BrickRequest"
  s.version          = "0.1.0"
  s.summary          = "BrickRequest is a helper library for Alamofire"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
  - BrickRequest is a helper library for Alamofire.
  - You can improve readability and DRYness when working with Alamofire.
  - BrickRequest provides several protocols.
    By using protocol extensions, you can build requests, just like building with LEGO bricks.
  - You can understand what the request does just by seeing the class signature.
  - Auto-retry ability is provided using `Reachability`
                       DESC

  s.homepage         = "https://github.com/muukii/BrickRequest"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "muukii" => "m@muukii.me" }
  s.source           = { :git => "https://github.com/muukii/BrickRequest.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'BrickRequest' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '~> 3.2.0'
end
