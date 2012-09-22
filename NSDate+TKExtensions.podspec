Pod::Spec.new do |s|
  s.name         = "NSDate+TKExtensions"
  s.version      = "0.1"
  s.summary      = "A short description of NSDate+TKExtensions."
  s.homepage     = "http://github.com/mapedd/NSDate+TKExtensions"
  s.license      = 'MIT'
  s.author       = { "Tomek Kuzma" => "mapedd@sezamkowa.net" }
  s.source       = { :git => "http://github.com/mapedd/NSDate+TKExtensions.git", :tag => "0.1" }
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.source_files = 'NSDate+TKExtensions.{h,m}'
  s.requires_arc = true
end
