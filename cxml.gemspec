require File.expand_path("../lib/cxml/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "cxml"
  s.version     = CXML::VERSION
  s.summary     = "Ruby library to work with cXML protocol"
  s.description = "Ruby library to work with cXML protocol"
  s.homepage    = "http://github.com/sosedoff/cxml"
  s.authors     = ["Dan Sosedoff"]
  s.email       = ["dan.sosedoff@gmail.com"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 3.4"

  s.add_dependency "nokogiri", "~> 1.6"
  s.add_dependency "xml-simple", "~> 1.1.5"
  s.add_dependency "hashr", "~> 2.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 2.3.1"
end