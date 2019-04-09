#
# Be sure to run `pod lib lint ReactiveCocoa.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ReactiveCocoa'
  s.version          = '2.5.1'
  s.summary          = 'ReactiveCocoa v2.5 without annoying warnings.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ReactiveCocoa v2.5 without annoying warnings.
                       DESC

  s.homepage         = 'https://github.com/IkeBanPC/RACCocoa'
  s.license          = 'MIT'
  s.author           = { 'IkeBanPC' => 'ikebanpc@gmail.com' }
  s.source           = { :git => 'https://github.com/IkeBanPC/RACCocoa.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'
  s.default_subspecs = 'UI'
  s.prepare_command = <<-'END'
    find . \( -regex '.*EXT.*\.[mh]$' -o -regex '.*metamacros\.[mh]$' \) -execdir mv {} RAC{} \;
    find . -regex '.*\.[hm]' -exec sed -i '' -E 's@"(EXT.*|metamacros)\.h"@"RAC\1.h"@' {} \;
    find . -regex '.*\.[hm]' -exec sed -i '' -E 's@<ReactiveCocoa/(EXT.*)\.h>@<ReactiveCocoa/RAC\1.h>@' {} \;
  END

  s.subspec 'no-arc' do |sp|
    sp.source_files = 'ReactiveCocoa/RACObjCRuntime.{h,m}'
    sp.requires_arc = false
  end

  s.subspec 'UI' do |sp|
    sp.dependency 'ReactiveCocoa/Core'
    sp.source_files = 'ReactiveCocoa/*{AppKit,NSControl,NSText,UI,MK}*'
    sp.ios.exclude_files = 'ReactiveCocoa/*{AppKit,NSControl,NSText}*'
    sp.osx.exclude_files = 'ReactiveCocoa/*{UI,MK}*'
  end

  s.subspec 'Core' do |sp|
    sp.dependency 'ReactiveCocoa/no-arc'
    sp.source_files = ["ReactiveCocoa/*.{d,h,m}", "ReactiveCocoa/extobjc/*.{h,m}"]
    sp.private_header_files = 'ReactiveCocoa/*Private.h'
    sp.exclude_files = 'ReactiveCocoa/*{RACObjCRuntime,AppKit,NSControl,NSText,UIActionSheet,UI,MK}*'
  end

end
