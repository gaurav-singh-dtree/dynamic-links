$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "dynamic_links/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "dynamic_links"
  spec.files       = `git ls-files`.split("\n")
  spec.version     = DynamicLinks::VERSION
  spec.authors     = ["Gaurav Singh"]
  spec.email       = ["gaurav.singh@coupa.com"]
  spec.homepage    = "http://www.todo.com"
  spec.summary     = "Summary of DynamicLinks."
  spec.description = "Description of DynamicLinks."
  spec.license     = "MIT"

  spec.add_development_dependency "rails", ">= 5.0"
end
