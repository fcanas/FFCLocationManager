#
# Be sure to run `pod lib lint FFCLocationManager.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "FFCLocationManager"
  s.version          = "0.1.0"
  s.summary          = "A short description of FFCLocationManager."
  s.description      = <<-DESC
                       An optional longer description of FFCLocationManager

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/<GITHUB_USERNAME>/FFCLocationManager"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Fabian Canas" => "fcanas@gmail.com" }
  s.source           = { :git => "https://github.com/fcanas/FFCLocationManager.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/fcanas'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'FFCLocationManager' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreLocation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
