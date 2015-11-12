# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parse_sberbank_html/version'

Gem::Specification.new do |spec|
  spec.name          = "parse_sberbank_html"
  spec.version       = ParseSberbankHtml::VERSION
  spec.authors       = ["Nikita B. Zuev"]
  spec.email         = ["nikitazu@gmail.com"]
  spec.summary       = %q{Parses Sberbank Online html}
  spec.description   = %q{Parses Sberbank Online html}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri", "~> 1.6"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 2.13"
end
