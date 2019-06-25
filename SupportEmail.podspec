Pod::Spec.new do |s|
  s.name             = 'SupportEmail'
  s.version          = '3.2.0'
  s.summary          = 'Prepopulates emails with support information in iOS apps'

  s.description      = <<-DESC
  SupportEmail is about simplifying support for apps. By prepopulating device information in your embedded support email link, you can save time and needless back and forth between you and your users.
                       DESC

  s.homepage         = 'https://github.com/schayes04/SupportEmail'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Stephen Hayes (Shayes Apps)' => 'support@shayesapps.com' }
  s.source           = { :git => 'https://github.com/schayes04/SupportEmail.git', :tag => s.version }
  s.social_media_url = 'https://twitter.com/shayesapps'

  s.swift_version = '5.0'
  s.ios.deployment_target = '8.0'
  s.source_files = 'Sources/SupportEmail/*.swift'
  s.ios.frameworks = 'UIKit', 'MessageUI'
end
