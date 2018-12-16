# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mozaic/version'

Gem::Specification.new do |spec|
  spec.name          = "mozaic"
  spec.version       = Mozaic::VERSION
  spec.authors       = ["mnc"]
  spec.email         = ["manchose9@gmail.com"]

  spec.summary       = %q{Mozaic is a ruby gem to dump database and mask its personal data.}
  spec.description   = %q{Mozaic is a ruby gem to dump database and mask its personal data. You can specify target columns to mask and masking method in YAML file. }
  spec.homepage      = "https://github.com/mnc/mozaic"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "thor", "~> 0.0"
  spec.add_dependency "activerecord", "~> 4.2", ">= 4.2.6"
  spec.add_dependency "mysql2", ">= 0.3.18", "< 0.5"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
