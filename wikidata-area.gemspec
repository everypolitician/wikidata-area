# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wikidata/area/version'

Gem::Specification.new do |spec|
  spec.name          = 'wikidata-area'
  spec.version       = Wikidata::Area::VERSION
  spec.authors       = ['Tony Bowden']
  spec.email         = ['tony@mysociety.org']

  spec.summary       = 'Fetch Wikidata info about constituencies/areas '
  spec.homepage      = 'https://github.com/everypolitician/wikidata-area'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop'
end
