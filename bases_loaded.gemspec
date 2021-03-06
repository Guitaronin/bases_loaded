# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bases_loaded/version"

Gem::Specification.new do |spec|
  spec.name          = "bases_loaded"
  spec.version       = BasesLoaded::VERSION
  spec.authors       = ["Arian Ryan"]
  spec.email         = ["arianryan@gmail.com"]
  spec.summary       = %q{Handle multiple connection pools in rails apps.}
  spec.homepage      = "https://github.com/Guitaronin"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.license          = 'MIT'
  spec.add_dependency 'rails', '~> 4'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3"
end
