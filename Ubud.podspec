Pod::Spec.new do |s|
  s.name = 'Ubud'
  s.version = '0.1.0'
  s.license = { :type => "MIT", :file => "LICENSE.md" }

  s.summary = 'Carousel photo browser library for iOS.'
  s.homepage = 'https://github.com/lkmfz/Ubud'
  s.social_media_url = 'https://twitter.com/lkmfz'
  s.author = { "Luqman Fauzi" => "luckman.fauzi@gmail.com" }

  s.source = { :git => 'https://github.com/lkmfz/Ubud.git', :tag => s.version }
  s.source_files = 'Ubud/Source/**/*.swift'

  s.pod_target_xcconfig = {
     "SWIFT_VERSION" => "4.0",
  }
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
end