$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "dynamic_links/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "dynamic_links"
  spec.files       = `git ls-files`.split("\n")
  spec.version     = DynamicLinks::VERSION
  spec.authors     = ["Gaurav Singh"]
  spec.email       = ["gaurav@dtreelabs.com"]
  spec.homepage    = "http://www.dtreelabs.com"
  spec.summary     = "Motivation for this gem comes from the requirement that sometimes applications needs to customize the links which they send for the campaigns or share on the social networking platforms."
  spec.description = "Motivation for this gem comes from the requirement that sometimes applications needs to customize the links which they send for the campaigns or share on the social networking platforms."
  spec.license     = "MIT"

  spec.add_dependency "hashids", "~>1.0"
  spec.add_development_dependency "rails", ">= 5.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
end
