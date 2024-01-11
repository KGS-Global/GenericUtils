#
#  Be sure to run `pod spec lint GenericUtils.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "GenericUtils"
  spec.version      = "0.0.1"
  spec.summary      = "Generic Utililty Frameworks."

  spec.description  = <<-DESC
                  Generic Utility Frameworks combined in a single pod.
                   DESC

  spec.homepage     = "https://github.com/KGS-Global/GenericUtils"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author       = { "KGS-Global" => "kgs.bitbucket.manager@gmail.com" }

  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/KGS-Global/GenericUtils.git", :tag => "#{spec.version}" }

  spec.source_files  = "Classes", "Classes/**/*.{h,m}"

  spec.source_files  = "GenericUtils", "GenericUtils/**/*.{h,m,swift}"
  spec.resources     = "GenericUtils/**/*.{png,xib,plist,xcassets}"

  spec.swift_version = "5.0"

end
