# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'cxml/version'

Gem::Specification.new do |s|
  s.name                  = 'cxml'
  s.version               = CXML::VERSION
  s.summary               = 'Ruby library to work with cXML protocol'
  s.description           = 'Ruby library to work with cXML protocol'
  s.homepage              = 'http://github.com/sosedoff/cxml'
  s.authors               = ['Dan Sosedoff']
  s.email                 = ['dan.sosedoff@gmail.com']
  s.files                 = Dir['lib/**/*'] + Dir['spec/**/*']
  s.required_ruby_version = '>= 2.3.1'

  s.add_development_dependency 'rspec', '~> 3.7'

  s.add_dependency 'ox', '~> 2.8.2'
end
