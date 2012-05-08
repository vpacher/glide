# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "glide/version"

Gem::Specification.new do |s|
  s.name        = "glide"
  s.version     = Glide::VERSION
  s.authors     = ["Volker Pacher"]
  s.email       = ["volker.pacher@gmail.com"]
  s.homepage    = "https://github.com/vpacher/glide"
  s.summary     = %q{a wrapper of the Glide Uk api}
  s.description = %q{allows you to get quotes from the glide api for the services required in one go and sum up the totals}

  s.rubyforge_project = "glide"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "httparty"
  s.add_runtime_dependency "json"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
