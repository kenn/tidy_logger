# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'tidy_logger'
  spec.version       = '1.0.1' # retrieve this value by: Gem.loaded_specs['redis-mutex'].version.to_s
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
