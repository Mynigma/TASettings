#
# Be sure to run `pod lib lint TASettings.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TASettings"
  s.version          = "0.1.4"
  s.summary          = "Easy to use settings view model"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
#  s.description      = <<-DESC
#                      DESC

  s.homepage         = "https://github.com/JanC/TASettings"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Jan Chaloupecky" => "jan.chaloupecky@gmail.com" }
  s.source           = { :git => "https://github.com/JanC/TASettings.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/TexTwil'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'TASettings' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'TransformerKit', '~> 0.5'
end
