Pod::Spec.new do |spec|
  spec.name         = 'KnightWatson'
  spec.version      = '0.1.1'
  spec.license      = 'MIT'
  spec.summary      = 'An Objective-C library which can offer almost every object themes.'
  spec.homepage     = 'https://github.com/coppercash/KnightWatson'
  spec.author       = { 'CopperCash' => 'coderdreamer@gmail.com' }
  spec.source       = { :git => 'https://github.com/coppercash/KnightWatson.git', :tag => spec.version }
  spec.source_files = 'KNWTheme/*.{h,m}', 'Cocoapods/KNWTheme.h'
  spec.exclude_files = 'KNWTheme/KNWTheme.h'
  spec.requires_arc = true
  spec.platform     = :ios, "7.0"
end