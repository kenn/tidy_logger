# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tidy_logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'tidy_logger'
  spec.version       = TidyLogger::VERSION
  spec.authors       = ['Kenn Ejima']
  spec.email         = ['kenn.ejima@gmail.com']
  spec.description   = %q{TidyLogger: Better API for Ruby’s stdlib Logger}
  spec.summary       = %q{TidyLogger: Better API for Ruby’s stdlib Logger}
  spec.homepage      = 'https://github.com/kenn/tidy_logger'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
