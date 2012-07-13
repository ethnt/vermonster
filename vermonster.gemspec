# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vermonster/version"

Gem::Specification.new do |gem|
  gem.name        = "vermonster"
  gem.version     = Vermonster::VERSION
  gem.authors     = ["Ethan Turkeltaub", "Johnathan Croom"]
  gem.email       = ["ethan.turkeltaub@gmail.com", "johnathancroom@gmail.com"]
  gem.homepage    = "http://github.com/eturk/vermonster"
  gem.summary     = %q{Consume all of the Cheddar (API).}
  gem.description = %q{Consume all of the Cheddar (API).}

  gem.rubyforge_project = "vermonster"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_dependency 'faraday', '~> 0.8.0'
  gem.add_dependency 'faraday_middleware', '~> 0.8.8'
  gem.add_dependency 'oauth', '~> 0.4.6'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'vcr'
end
