Pod::Spec.new do |s|

    s.name             = "DisplaySwitcher"
    s.version          = "2.0"
    s.swift_version    = '5.0'
    s.summary          = "This component implements custom transition between two collection view layouts."

    s.homepage         = "https://github.com/sailingX/DisplaySwitcher"
    s.license          = { :type => "MIT", :file => "LICENSE" }
    s.author           = "Yalantis"
    s.social_media_url = "https://twitter.com/yalantis"

    s.ios.deployment_target = '13.0'

    s.source           = { :git => "https://github.com/sailingX/DisplaySwitcher.git", :tag => s.version }
    s.source_files     = 'Pod/Classes/**/*'

    s.requires_arc     = true
end
