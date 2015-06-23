
Pod::Spec.new do |s|

  s.name         = "LoL"
  s.version      = "0.0.1"
  s.summary      = "A Swift wrapper for Riot's League of Legends API"
  s.description  = <<-DESC
                   This is to be a dependency free wrapper to be used with your favorite networking method.  Simply create an instance of the Class, call the appropriate get method, then use the URL property to make a request using whatever you like to use.
                   DESC
  s.homepage     = "https://github.com/Akcbryant/LoL"
  s.license      = "MIT"
  s.author             = { "akcbryant" => "akcbryant@gmail.com" }
  s.social_media_url   = "http://twitter.com/KirbyBryant"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Akcbryant/LoL.git", :tag => "0.0.1" }
  s.source_files  = "LoL.swift"

end
