# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "feather_cms/version"

Gem::Specification.new do |s|
  s.name        = "feather_cms"
  s.version     = FeatherCms::VERSION
  s.authors     = ["Jiren Patel"]
  s.email       = ["jiren@joshsoftware.com"]
  s.homepage    = ""
  s.summary     = %q{Lightweight do it youself cms}
  s.description = %q{Lightweight do it youself cms}

  s.rubyforge_project = "feather_cms"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
