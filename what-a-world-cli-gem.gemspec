# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'what_a_world/version'

Gem::Specification.new do |spec|
  spec.name          = "what-a-world"
  spec.version       = WhatAWorld::VERSION
  spec.author        = ["Greg B"]
  spec.authors       = ["gb23"]
  spec.email         = ["gregbenj@hotmail.com"]
  spec.files         = ["lib/what_a_world.rb"]
  spec.summary       = %q{What a world!  Displays transnational issues by country}
  spec.description   = %q{What a world! Choose a country to learn about various transnational issues that hinder global progress, as recognized by the CIA }
  spec.homepage      = "https://github.com/gb23/what-a-world-cli-gem/"
  spec.license       = "MIT"
  spec.require_paths = ["lib" "lib/what_a_world"]
  spec.platform      = Gem::Platform::RUBY
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
 
  spec.executables = ["what-a-world"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'nokogiri'
  spec.add_dependency 'colorize'
end
