# lib = File.expand_path("lib", __dir__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# require "nimiq/version"
require_relative "lib/ruby-client"

Gem::Specification.new do |spec|
  spec.name = "nimiq-ruby-client"
  spec.version = Nimiq::VERSION
  spec.authors = ["jxdv"]
  spec.email = ["root@localhost"]

  spec.summary = %q{Ruby implementation of the Nimiq RPC client specification.}
  spec.description = %q{Ruby implementation of the Nimiq RPC client specification.}
  spec.homepage = "https://github.com/jxdv/ruby-client"
  spec.license = "Apache-2.0"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jxdv/ruby-client"
  spec.metadata["changelog_uri"] = "https://github.com/jxdv/ruby-client/readme.md"

  spec.add_dependency "oj", "~> 2.15"

  spec.files = Dir["lib/*.rb"] + Dir["lib/nimiq/*.rb"]
  spec.files += Dir["bin/*"] + Dir["spec/**/*"]
  spec.files.reject! { |fn| fn.include? "CVS" }
  # spec.files.reject! { Dir["doc"] }
  # spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
