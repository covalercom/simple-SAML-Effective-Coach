
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "simple_saml/version"

Gem::Specification.new do |spec|
  spec.name          = "simple_saml"
  spec.version       = SimpleSaml::VERSION
  spec.authors       = ["Daniel Wachtel", "Peter O'Sullivan"]
  spec.email         = ["peter@effective.coach"]

  spec.summary       = %q{Beddoes SAML authentication gem}
  spec.description   = %q{Beddoes SAML authentication gem}
  spec.homepage      = "https://github.com/covalercom/simple-SAML-Effective-Coach"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "ruby-saml", "~> 1.11"
end
