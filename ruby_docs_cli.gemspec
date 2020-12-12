require_relative 'lib/ruby_docs_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_docs_cli"
  spec.version       = RubyDocsCli::VERSION
  spec.authors       = ["Mnkith"]
  spec.email         = ["munkithabid@gmail.com"]

  spec.summary       = 'An interactive CLI tool to display Ruby classes and methods on the terminal'
  spec.description   = 'A gem that enables you to display full description of Ruby core classess and methods right from your IDE terminal.'
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency 'open-uri'
  spec.add_development_dependency 'colorize'
  spec.add_development_dependency "rake", "~> 12.0"

end
