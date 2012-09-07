$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "feather_cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "feather_cms"
  s.version     = FeatherCms::VERSION
  s.authors     = ["Jiren Patel, Prasad Surase, Pratik Shah"]
  s.email       = ["jiren@joshsoftware.com, prasad@joshsoftware.com, pratik@joshsoftware.com"]
  s.homepage    = ""
  s.summary     = %q{Lightweight do it youself cms}
  s.description = %q{Lightweight do it youself cms}

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 3.2.5'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'haml', '>= 3.0.0'
  s.add_dependency 'sass-rails'
  s.add_dependency 'bootstrap-sass', '2.0.4.0'

  s.add_development_dependency 'sqlite3'
end
