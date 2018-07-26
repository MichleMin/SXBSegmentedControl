
Pod::Spec.new do |s|

  s.name         = "SXBSegmentedControl"
  s.version      = "0.1.0"
  s.summary      = "横向滑动导航栏菜单"
  s.description  = "横向滑动导航栏菜单"
  s.homepage     = "https://github.com/MichleMin/SXBSegmentedControl"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MichleMin' => '286888980@qq.com' }
  s.source           = { :git => 'https://github.com/MichleMin/SXBSegmentedControl.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files  = "SXBSegmentedControl/Sources/*.{swift,h}"
  s.frameworks = 'UIKit'
  s.requires_arc = true

end
