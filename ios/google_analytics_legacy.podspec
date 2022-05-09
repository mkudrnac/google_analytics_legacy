#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint google_analytics_legacy.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'google_analytics_legacy'
  s.version          = '1.0.3'
  s.summary          = 'Flutter plugin for Google Analytics (Universal Analytics).'
  s.description      = <<-DESC
  Legacy Google Analytics plugin.
                       DESC
  s.homepage         = 'https://github.com/mkudrnac/google_analytics_legacy'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Miroslav Kudrnac' => 'kudrnac.miroslav@centrum.cz' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'GoogleAnalytics', '3.20.0'
  s.dependency 'GoogleIDFASupport', '3.14.0'
  s.platform = :ios, '8.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
