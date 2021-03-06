# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'feedes/version'

Gem::Specification.new do |spec|
  spec.name          = "feedes"
  spec.version       = Feedes::VERSION
  spec.authors       = ["hirakiuc"]
  spec.email         = ["hirakiuc@gmail.com"]

  spec.summary       = %q{a ruby library to parse RSS Feed}
  spec.description   = %q{a ruby library to parse RSS Feed which support rdf, rss 2.0, atom}
  spec.homepage      = 'https://github.com/hirakiuc/feedes'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.52.1"
  spec.add_development_dependency "sinatra", "~> 2.0.1"
  spec.add_development_dependency "webmock", "~> 3.3.0"
  spec.add_development_dependency 'simplecov', '0.14.1'
  spec.add_development_dependency "codeclimate-test-reporter", "~> 1.0"
  spec.add_development_dependency 'yard', '0.9.12'
  spec.add_dependency 'nokogiri', '~> 1.8.2'
  spec.add_dependency 'rest-client', '~> 2.0.2'
end
