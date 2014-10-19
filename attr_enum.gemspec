$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "attr_enum/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "attr_enum"
  s.version     = AttrEnum::VERSION
  s.authors     = ["Ricardo Quiñones"]
  s.email       = ["r.a.quinones@gmail.com"]
  s.homepage    = ""
  s.summary     = "Makes integer type columns function similarly to enum columns."
  s.description = "A simple and declarative way to make integer type columns that are used to signal the state of a model/object function more like enums in code."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.18"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
