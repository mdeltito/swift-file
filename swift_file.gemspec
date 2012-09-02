# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swift_file/version'

Gem::Specification.new do |gem|
  gem.name          = "swift_file"
  gem.version       = SwiftFile::VERSION
  gem.authors       = ["Michael Del Tito"]
  gem.email         = ["mdeltito@contextllc.com"]
  gem.description   = %q{Upload a file to the SwiftFile service}
  gem.summary       = %q{Upload a file to the SwiftFile service}
  gem.homepage      = "http://contextllc.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
  gem.add_dependency("rest-client", ">= 1.6.7")
  gem.add_dependency("curb", ">= 0.8.1")

end
