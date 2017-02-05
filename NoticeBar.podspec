
Pod::Spec.new do |s|

  s.name         = "NoticeBar"
  s.version      = "0.1.5"
  s.summary      = "😍A simple NoticeBar with QQ notice view style.😀"
  s.description  = <<-DESC
                  😍A simple NoticeBar with QQ notice view style.😀 You can use the default style or custom style.
                   DESC

  s.homepage     = "https://github.com/qiuncheng/NoticeBar"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Qiuncheng" => "qiuncheng@gmail.com" }
  # s.social_media_url   = "https://twitter.com/qiuncheng"

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/qiuncheng/NoticeBar.git", :tag => s.version }
  s.source_files  = 'NoticeBar/*.{swift,h}'
  s.resource_bundles = {'NoticeBar' => ['NoticeBar/*.xcassets']}
  
  s.framework  = "UIKit"
  s.requires_arc = true

end
