#
#  Be sure to run `pod spec lint JCGPasswordStrength.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|


  spec.name         = "JCGPasswordStrength"
  spec.version      = "0.0.1"
  spec.summary      = "PasswordStrength with Objective-C"
  spec.description  = <<-DESC
  A PasswordStrength with Objective, by the strength score 
                   DESC

  spec.homepage     = "https://github.com/jcg9487/JCGPasswordStrength"
  spec.license      = "MIT"
  spec.author       = { "EdwardJCG" => "jcg9487@163.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/jcg9487/JCGPasswordStrength.git", :tag => "v0.0.1" }
  spec.source_files  = "PasswordStrength", "PasswordStrength/PasswordStrength/PasswordStrengthUtil/PasswordStrengthUtil.{h,m}"

 




end
