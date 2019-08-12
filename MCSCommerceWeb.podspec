Pod::Spec.new do |s|
  s.name         = "MCSCommerceWeb"
  s.version      = "1.0.0"
  s.summary      = "Objective-C iOS wrapper for Mastercard's web SRC Initiator"
  s.homepage     = "https://github.com/Mastercard/MCSCommerceWeb"
  s.license      = "Apache License, Version 2.0"
  s.author             = { "Bret Deasy" => "bjdeasy@gmail.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/Mastercard/MCSCommerceWeb.git", :tag => "1.0.0" }
  s.source_files  = "MCSCommerceWeb", "MCSCommerceWeb/**/*.{h,m}"
  s.public_header_files = "MCSCommerceWeb/Public/**/*.h"
  s.resources = "MCSCommerceWeb/Resources/**/*.{png,html,xcassets,xib}"
end
