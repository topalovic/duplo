# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "duplo/version"

Gem::Specification.new do |s|
  s.name          = "duplo"
  s.version       = Duplo::VERSION
  s.date          = "2015-05-09"
  s.authors       = ["Nikola Topalović"]
  s.email         = ["nikola.topalovic@gmail.com"]

  s.summary       = %q{Generating nested collections with minimum effort.}
  s.description   = %q{Generating nested collections with minimum effort.}
  s.homepage      = "https://github.com/topalovic/duplo"
  s.license       = "MIT"

  s.require_paths = ["lib"]

  s.files = Dir[
    "LICENSE",
    "README.md",
    "CHANGELOG.md",
    "lib/**/*.rb"
  ]

  s.test_files = Dir['spec/**/*_spec.rb']

  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.2"

  s.required_ruby_version = ">= 1.9.2"
end
