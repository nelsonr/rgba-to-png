# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rgba-png/version'

Gem::Specification.new do |spec|
  spec.name          = "rgba-png"
  spec.version       = RgbaPng::VERSION
  spec.authors       = ["Nelson Rodrigues"]
  spec.email         = ["nelson@fullfront.pt"]
  spec.description   = %q{Command line tool that creates PNG image files from rgba definitions in stylesheets.}
  spec.summary       = %q{Creates PNG image files from rgba definitions in stylesheets.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "oily_png"
end
