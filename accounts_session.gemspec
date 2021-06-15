# frozen_string_literal: true

require_relative "lib/accounts_session/version"

Gem::Specification.new do |spec|
  spec.name          = "accounts_session"
  spec.version       = AccountsSession::VERSION
  spec.authors       = ["Robin Bortlik"]
  spec.email         = ["robinbortlik@gmail.com"]

  spec.summary       = "Learnlife account authentication library"
  spec.description   = "Authenticate learnlife account based on passed JWT token"
  spec.homepage      = "https://github.com/learnlifecom/accounts_session/"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/learnlifecom/accounts_session/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "redis", "~> 4.2"
  spec.add_dependency "jwt", "~> 2.2"

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.1"
  spec.add_development_dependency "rubocop-rspec", "~> 2.4"
  spec.add_development_dependency "rubocop-rake", "~> 0.5"
  spec.add_development_dependency "bundler-audit", "~> 0.8"
  spec.add_development_dependency "fasterer", "~> 0.9"
  spec.add_development_dependency "pry", "~> 0.1"
end
