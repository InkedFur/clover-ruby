# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'clover/version'

Gem::Specification.new do |spec|
  spec.name          = "clover-ruby"
  spec.version       = Clover::VERSION
  spec.authors       = ["William Eisert"]
  spec.email         = ["weisert@eisertdev.com"]

  spec.summary       = %q{Ruby wrapper for the Clover.com REST API}
  spec.description   = %q{Ruby wrapper for the Clover.com REST API}
  spec.homepage      = "https://github.com/inkedfur/clover-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'simplecov'

  spec.add_dependency 'her'
  spec.add_dependency 'oauth2'
end
