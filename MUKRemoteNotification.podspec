Pod::Spec.new do |s|
  s.name             = "MUKRemoteNotification"
  s.version          = "1.0.0"
  s.summary          = "Parse incoming remote (push) notification"
  s.description      = "You feed dictionary contained inside UIApplicationLaunchOptionsRemoteNotificationKey and you get a parsed object"
  s.homepage         = "https://github.com/muccy/MUKRemoteNotification"
  s.license          = 'MIT'
  s.author           = { "Marco Muccinelli" => "muccymac@gmail.com" }
  s.source           = { :git => "https://github.com/muccy/MUKRemoteNotification.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/**/*.{h,m}'
  s.compiler_flags  = '-Wdocumentation'
end
