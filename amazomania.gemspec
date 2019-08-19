# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'amazomania/version'

Gem::Specification.new do |spec|
  spec.name          = "amazomania"
  spec.version       = Amazomania::VERSION
  spec.authors       = ["Osamu Takiya"]
  spec.email         = ["takiya@toran.sakura.ne.jp"]

  spec.summary       = %q{get lowest product price at amazon.co.jp}
  spec.description   = %q{as product sold at amazon.co.jp, you can get lowest price, shop name, shipping price...etc}
  spec.homepage      = "https://github.com/corselia/amazomania"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "nokogiri"
  spec.add_dependency "capybara"
  spec.add_dependency "poltergeist"
end
